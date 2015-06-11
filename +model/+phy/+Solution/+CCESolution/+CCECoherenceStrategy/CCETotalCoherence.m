classdef CCETotalCoherence < handle
    %ECCETOTALCOHERENCE 
    
    properties
        cluster_iter
        cluster_coherence_strategy
        center_spin
        cluster_cell
        coherence_matrix
        cluster_coherence_tilde_matrix
        coherence
    end
    
    methods
        function obj=CCETotalCoherence(cluster_iter,center_spin,strategy)
            obj.cluster_iter=cluster_iter;
            obj.center_spin=center_spin;
            obj.cluster_coherence_strategy=strategy;
            obj.generate_cluster_cell();
        end
        
        function generate_cluster_cell(obj)
            iter=obj.cluster_iter;
            iter.setCursor(1);
            ncluster=length(iter.index_list);
            clu_cell=cell(1,ncluster);
%             while ~iter.isLast() 
            for n=1:ncluster
%                 bath_cluster=iter.currentItem();
                bath_cluster=iter.getItem(n);
                central_espin={obj.center_spin.espin};
                cluster=model.phy.SpinCollection.SpinCollection();
                cluster.spin_source=model.phy.SpinCollection.Strategy.FromSpinList([central_espin, bath_cluster]);
                cluster.generate();
                clu_cell{1,n}=cluster;
%                 iter.moveForward();
            end
            obj.cluster_cell=clu_cell;
        end
        
        function calculate_total_coherence(obj,center_spin_states,timelist,varargin)
           p = inputParser;
           addRequired(p,'center_spin_states');
           addRequired(p,'timelist');
           addOptional(p,'npulse',0,@isnumeric);
           addOptional(p,'is_secular',0,@isnumeric); 
            
           parse(p,center_spin_states,timelist,varargin{:});
            
           center_spin_states=p.Results.center_spin_states;
           is_secular=p.Results.is_secular;
           timelist=p.Results.timelist;
           npulse=p.Results.npulse;
            
           ncluster=obj.cluster_iter.getLength;
           ntime=length(timelist);
           CoherenceMatrix=zeros(ncluster,ntime);
           clu_cell=obj.cluster_cell;
           strategy_name=obj.cluster_coherence_strategy;
           disp('calculate the cluster-coherence matrix ...');
           tic
           for n=1:ncluster              
              cluster=clu_cell{n};
              strategy=model.phy.Solution.CCESolution.CCECoherenceStrategy.(strategy_name);
              strategy.generate(cluster);
              CoherenceMatrix(n,:)=strategy.calculate_cluster_coherence(center_spin_states,timelist,'npulse',npulse,'is_secular',is_secular);
            end
            obj.coherence_matrix=CoherenceMatrix;
            toc
            disp('calculation of the cluster-coherence matrix finished.');

            obj.CoherenceTilde(CoherenceMatrix);            
        end
        function CoherenceTilde(obj,cohmat)
            subcluster_list=obj.cluster_iter.cluster_info.subcluster_list;
            cluster_number_list=[obj.cluster_iter.cluster_info.cluster_number_list{:,2}];
            
            nclusters=length(subcluster_list);
            ntime=length(cohmat(1,:));
            coh_tilde_mat=zeros(nclusters,ntime);
            coh_total=ones(1,ntime);
            coh=struct();
            
            cceorder=1;
            endpoints=cumsum(cluster_number_list);
            for m=1:nclusters
                subcluster=subcluster_list{m};
                nsubcluster=length(subcluster);
                coh_tilde=cohmat(m,:);
                if nsubcluster==0
                    coh_tilde_mat(m,:)= coh_tilde;
                elseif nsubcluster>0
                    for n=1:nsubcluster;
                        coh_tilde_sub=coh_tilde_mat(subcluster(n),:);
                        coh_tilde=coh_tilde./coh_tilde_sub;
                    end
                    coh_tilde_mat(m,:)=coh_tilde;
                end

                coh_total=coh_total.*coh_tilde;
                if m==endpoints(1,cceorder)
                    field_name=strcat('coherence_cce_',num2str(cceorder));
                    coh.(field_name)=coh_total;
                    cceorder=cceorder+1;
                end
            end
            coh.('coherence')= coh_total; 
            
            obj.cluster_coherence_tilde_matrix=coh_tilde_mat;
            obj.coherence=coh;
        end

        
    end
    
end


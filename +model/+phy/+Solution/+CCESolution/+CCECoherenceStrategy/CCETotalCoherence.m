classdef CCETotalCoherence < handle
    %ECCETOTALCOHERENCE 
    
    properties
        cluster_iter
        cluster_number
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
            ncluster=iter.cluster_info.cluster_number;
            obj.cluster_number=ncluster;
            iter.setCursor(1);
            ncluster=length(iter.index_list);
            clu_cell=cell(1,ncluster);

            for n=1:ncluster

               bath_cluster=iter.getItem(n);
               central_espin={obj.center_spin.espin};
               cluster=model.phy.SpinCollection.SpinCollection();
               cluster.spin_source=model.phy.SpinCollection.Strategy.FromSpinList([central_espin, bath_cluster]);
               cluster.generate();
                
               strategy_name=obj.cluster_coherence_strategy;
               cluster_strategy=model.phy.Solution.CCESolution.CCECoherenceStrategy.(strategy_name);
               cluster_strategy.generate(cluster);
               clu_cell{1,n}=cluster_strategy;

            end
            obj.cluster_cell=clu_cell;
        end
        
        function calculate_total_coherence(obj,center_spin_states,timelist,varargin)
           p = inputParser;
           addRequired(p,'center_spin_states');
           addRequired(p,'timelist');
           addOptional(p,'npulse',0,@isnumeric);
           addOptional(p,'is_secular',0,@isnumeric); 
           addOptional(p,'magnetic_field',[0,0,0]);
           parse(p,center_spin_states,timelist,varargin{:});
            
           center_spin_states=p.Results.center_spin_states;
           is_secular=p.Results.is_secular;
           timelist=p.Results.timelist;
           npulse=p.Results.npulse;
           MagneticField=p.Results.magnetic_field;
            
           ncluster=obj.cluster_iter.getLength;
           ntime=length(timelist);
           CoherenceMatrix=zeros(ncluster,ntime);
           clu_cell=obj.cluster_cell;

           disp('calculate the cluster-coherence matrix ...');
           tic
           parfor n=1:ncluster 
              Condition=model.phy.LabCondition.getCondition;
              Condition.setValue('magnetic_field',MagneticField);
              cluster=clu_cell{1,n};
              CoherenceMatrix(n,:)=cluster.calculate_cluster_coherence(center_spin_states,timelist,'npulse',npulse,'is_secular',is_secular);
              clu_cell{1,n}=0;
           end
           delete(gcp('nocreate'));
           toc
           disp('calculation of the cluster-coherence matrix finished.');
           save([OUTPUT_FILE_PATH, 'coherence_matrix', obj.timeTag, '.mat'],'CoherenceMatrix');

            obj.CoherenceTilde(CoherenceMatrix);
            obj.coherence.timelist=timelist;
            if ncluster<20000
                obj.coherence_matrix=CoherenceMatrix;
            else
                clear CoherenceMatrix;
            end
        end
        function CoherenceTilde(obj,cohmat)
            subcluster_list=obj.cluster_iter.cluster_info.subcluster_list;
            cluster_number_list=[obj.cluster_iter.cluster_info.cluster_number_list{:,2}];
            
            ncluster=length(subcluster_list);
            ntime=length(cohmat(1,:));
            coh_tilde_mat=zeros(ncluster,ntime);
            coh_total=ones(1,ntime);
            coh=struct();
            
            cceorder=1;
            endpoints=cumsum(cluster_number_list);
            for m=1:ncluster
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
            save([OUTPUT_FILE_PATH, 'coherence_tilde_matrix', obj.timeTag, '.mat'],'coh_tilde_mat');
           if ncluster<20000          
               obj.cluster_coherence_tilde_matrix=coh_tilde_mat;
           else
               clear coh_tilde_mat;
           end
            obj.coherence=coh;
        end

        
    end
    
end


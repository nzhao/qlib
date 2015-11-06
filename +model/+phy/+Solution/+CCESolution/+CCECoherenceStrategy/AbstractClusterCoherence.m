classdef AbstractClusterCoherence < handle
    %ABSTRACTCLUSTERCOHERENCE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
      spin_collection
      coherence
      hamiltonian_list
      preoperator_factor
      npulse
    end
    
    methods
        function obj=AbstractClusterCoherence(cluster)            
            if nargin>0
                obj.generate(cluster);
            end
        end 
        function generate(obj,cluster)
            obj.spin_collection=cluster;
        end
        %  generate reduced hamiltonian for the given central spin states
        function reduced_hami = gen_reduced_hamiltonian(obj,center_spin_state,is_secular)
            cluster=obj.spin_collection;
            hami_cluster=model.phy.QuantumOperator.SpinOperator.Hamiltonian(cluster);
            zee_interaction=model.phy.SpinInteraction.ZeemanInteraction(cluster);
            dip_interaction=model.phy.SpinInteraction.DipolarInteraction(cluster);
            hami_cluster.addInteraction(zee_interaction);
            hami_cluster.addInteraction(dip_interaction);
            ts=model.phy.QuantumOperator.SpinOperator.TransformOperator(cluster,{'1.0 * eigenVectors()_1'});
            hami_cluster.transform(ts);

            hami1=hami_cluster.project_operator(1, center_spin_state(1));
            hami2=hami_cluster.project_operator(1, center_spin_state(2));
            hami1.remove_identity();
            hami2.remove_identity();

            if is_secular && hami1.spin_collection.getLength>1
                approx1=model.phy.SpinApproximation.SpinSecularApproximation(hami1.spin_collection);
                approx2=model.phy.SpinApproximation.SpinSecularApproximation(hami2.spin_collection);
                hami1.apply_approximation(approx1);
                hami2.apply_approximation(approx2);
            end

            reduced_hami=cell(1,2);
            reduced_hami{1,1}=hami1;
            reduced_hami{1,2}=hami2;
        end
        
        % Generate hamiltonian list for the evolution of ensemble CCE with a given pulse number
        function  [hami_list,time_seq]= gen_hami_list(obj,hamiCell)
            time_seq=obj.time_ratio_seq();
            len_time_seq=length(time_seq);
            hami_list=cell(1,len_time_seq);
            p_list=(1:len_time_seq)+obj.npulse;
            parity_list=rem(p_list,2);
            for m=1:len_time_seq %initial the core matrice
                 parity=parity_list(m); 
                 switch parity
                        case 0
                            hami=hamiCell{1,1};                       
                        case 1
                            hami=hamiCell{1,2};
                        otherwise
                            error('wrong parity of the index of the hamiltonian sequence.');
                 end
                 hami_list{m}=hami;
            end
            obj.hamiltonian_list=hami_list;
            obj.preoperator_factor=time_seq;
        end

        function time_seq = time_ratio_seq(obj)
            if obj.npulse==0
                time_seq=[-1,1];
            elseif obj.npulse>0
                nsegment=obj.npulse+1;
                step=1/obj.npulse/2;
                seq=zeros(1,nsegment);
                for n=1:nsegment
                    if n==1
                        seq(1,n)=step;
                    elseif n==nsegment
                        seq(1,n)=step;
                    else
                        seq(1,n)=2*step;
                    end
                end
                time_seq=[-1*seq,seq];
            end     
        end
    end
    
    methods (Abstract)
        coh=calculate_cluster_coherence(obj,para);
    end
    
end


classdef ECCEClusterCoherence < model.phy.Solution.CCESolution.CCECoherenceStrategy.AbstractClusterCoherence
    %ECCECLUSTERCOHERENCE 
                %calculate the coherence of single cluster for ensemble CCE 
    properties
      coherence_tilde
    end
    
    methods
        function obj=ECCEClusterCoherence(cluster)
            obj@model.phy.Solution.CCESolution.CCECoherenceStrategy.AbstractClusterCoherence();
            if nargin >0
               obj.generate(cluster); 
            end                    
        end
        
        function coh=calculate_cluster_coherence(obj,para)
            import model.phy.QuantumOperator.SpinOperator.DensityMatrix
            import model.phy.QuantumOperator.SpinOperator.Observable
            import model.phy.Dynamics.QuantumDynamics
            import model.phy.SpinCollection.SpinCollection  
            import model.phy.SpinCollection.Strategy.FromSpinList
            import model.phy.Dynamics.EvolutionKernel.DensityMatrixEvolution
            import model.phy.SpinApproximation.SpinSecularApproximation

            obj.npulse=para.NPulse;
            center_spin_states=para.SetCentralSpin.CentralSpinStates;
            is_secular=para.IsSecularApproximation;
            
            hamiCell=obj.gen_reduced_hamiltonian(center_spin_states,is_secular);
            [hami_list,hami_prefactor]=obj.gen_hami_list(hamiCell);

            % DensityMatrix
            bath_cluster=obj.spin_collection.spin_list(2:end);
            denseMat=DensityMatrix(SpinCollection( FromSpinList(bath_cluster)));
            dim=denseMat.dim;
            denseMat.setMatrix(eye(dim)/dim);

            %Observable
            obs=Observable(SpinCollection( FromSpinList(bath_cluster)));
            obs.setMatrix(1);

            % Evolution
            dynamics=QuantumDynamics( DensityMatrixEvolution(hami_list,hami_prefactor) );
            dynamics.set_initial_state(denseMat,'Hilbert');
            timelist=para.TimeList;
            dynamics.set_time_sequence(timelist);
            dynamics.addObervable({obs});
            dynamics.calculate_mean_values();
            coh=dynamics.observable_values;
            obj.coherence=coh;
        end
        
        function calculater_cluster_coherence_tilde(obj,para,subclusters)

        end
        

        
    end
    
end


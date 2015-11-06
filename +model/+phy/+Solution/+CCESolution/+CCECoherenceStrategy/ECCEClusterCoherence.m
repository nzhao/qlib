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
        
        function coh=calculate_cluster_coherence(obj,center_spin_states,timelist,varargin)
            p = inputParser;
            addRequired(p,'center_spin_states');
            addRequired(p,'timelist');
            addOptional(p,'npulse',0,@isnumeric);
            addOptional(p,'is_secular',0,@isnumeric); 

            parse(p,center_spin_states,timelist,varargin{:});

            obj.npulse=p.Results.npulse;
            center_spin_states=p.Results.center_spin_states;
            is_secular=p.Results.is_secular;
            timelist=p.Results.timelist;

            hamiCell=obj.gen_reduced_hamiltonian(center_spin_states,is_secular);
            [hami_list,hami_prefactor]=obj.gen_hami_list(hamiCell);

            % DensityMatrix
            bath_spins=obj.spin_collection.spin_list(2:end);
            bath_cluster= model.phy.SpinCollection.SpinCollection();
            bath_cluster.spin_source=model.phy.SpinCollection.Strategy.FromSpinList(bath_spins);
            bath_cluster.generate();
            denseMat=model.phy.QuantumOperator.SpinOperator.DensityMatrix(bath_cluster);
            dim=denseMat.dim;
            denseMat.setMatrix(eye(dim)/dim);

            %Observable
            obs=model.phy.QuantumOperator.SpinOperator.Observable(bath_cluster);
            obs.setMatrix(1);

            % Evolution
            d_mat_evolution=model.phy.Dynamics.EvolutionKernel.ObservableMatrixEvolution(hami_list,hami_prefactor);
            dynamics=model.phy.Dynamics.QuantumDynamics(d_mat_evolution);
            dynamics.set_initial_state(denseMat,'Hilbert');

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


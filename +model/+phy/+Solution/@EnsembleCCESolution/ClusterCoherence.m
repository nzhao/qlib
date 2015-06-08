function coh = ClusterCoherence(obj, cluster, TimeList)
%CLUSTERCOHERENCE Summary of this function goes here
%   calculate the coherence of single cluster

    hami_cluster=Hamiltonian(cluster);
    hami_cluster.addInteraction( ZeemanInteraction(cluster) );
    hami_cluster.addInteraction( DipolarInteraction(cluster) );
    hamiCell=obj.gen_reduced_hamiltonian(cluster,hami_cluster);
    [hami_list,time_seq]=obj.gen_hami_list(hamiCell);


    %% DensityMatrix
    denseMat=DensityMatrix(SpinCollection( FromSpinList(bath_cluster)));
    dim=denseMat.dim;
    denseMat.setMatrix(eye(dim)/dim);
    %% Observable
    obs=Observable(SpinCollection( FromSpinList(bath_cluster)));
    obs.setMatrix(1);

    %% Evolution
    dynamics=QuantumDynamics( DensityMatrixEvolution(hami_list,time_seq) );
    dynamics.set_initial_state(denseMat,'Hilbert');
    dynamics.set_time_sequence(TimeList);
    dynamics.addObervable({obs});
    dynamics.calculate_mean_values();
    coh=dynamics.observable_values;
end


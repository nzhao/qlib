function coh = ClusterCoherence(obj, cluster_idx)
%CLUSTERCOHERENCE Summary of this function goes here
%   calculate the coherence of single cluster
    import model.phy.SpinInteraction.ZeemanInteraction
    import model.phy.SpinInteraction.DipolarInteraction
    import model.phy.QuantumOperator.SpinOperator.Hamiltonian
    import model.phy.QuantumOperator.SpinOperator.DensityMatrix
    import model.phy.QuantumOperator.SpinOperator.Observable
    import model.phy.Dynamics.QuantumDynamics
    import model.phy.SpinCollection.SpinCollection  
    import model.phy.SpinCollection.Strategy.FromSpinList
    import model.phy.Dynamics.EvolutionKernel.DensityMatrixEvolution
    import model.phy.SpinApproximation.SpinSecularApproximation
    
    cluster=obj.getCluster(cluster_idx);
    para=obj.parameters;
    
    hami_cluster=Hamiltonian(cluster);
    hami_cluster.addInteraction( ZeemanInteraction(cluster) );
    hami_cluster.addInteraction( DipolarInteraction(cluster) );
    center_spin_states=para.SetCentralSpin.CentralSpinStates;

    is_secular=para.IsSecularApproximation;
    hamiCell=gen_reduced_hamiltonian(cluster,hami_cluster,center_spin_states,is_secular);
    
    npulse=para.NPulse; 
    [hami_list,time_seq]=gen_hami_list(hamiCell,npulse);

    % DensityMatrix
    bath_cluster=cluster.spin_list(2:end);
    denseMat=DensityMatrix(SpinCollection( FromSpinList(bath_cluster)));
    dim=denseMat.dim;
    denseMat.setMatrix(eye(dim)/dim);
    
    %Observable
    obs=Observable(SpinCollection( FromSpinList(bath_cluster)));
    obs.setMatrix(1);

    % Evolution
    dynamics=QuantumDynamics( DensityMatrixEvolution(hami_list,time_seq) );
    dynamics.set_initial_state(denseMat,'Hilbert');
    timelist=para.TimeList;
    dynamics.set_time_sequence(timelist);
    dynamics.addObervable({obs});
    dynamics.calculate_mean_values();
    coh=dynamics.observable_values;
end


function reduced_hami = gen_reduced_hamiltonian(cluster,hami_cluster,center_spin_state,is_secular)
%GEN_REDUCED_HAMILTONIAN 
%  generate reduced hamiltonian for the given central spin states
    ts=model.phy.QuantumOperator.SpinOperator.TransformOperator(cluster,{'1.0 * eigenVectors()_1'});
    hami_cluster.transform(ts);

    hami1=hami_cluster.project_operator(1, center_spin_state(1));
    hami2=hami_cluster.project_operator(1, center_spin_state(2));
    hami1.remove_identity();
    hami2.remove_identity();
   
    if is_secular && hami1.spin_collection.getLength>1
        import model.phy.SpinApproximation.SpinSecularApproximation
        hami1.apply_approximation( SpinSecularApproximation(hami1.spin_collection) );
        hami2.apply_approximation( SpinSecularApproximation(hami2.spin_collection) );
    end
    
    reduced_hami=cell(1,2);
    reduced_hami{1,1}=hami1;
    reduced_hami{1,2}=hami2;
end
function  [hami_list,time_seq]= gen_hami_list(hamiCell,npulse)
% Generate hamiltonian list for the evolution of ensemble CCE with a given pulse number

        time_seq=time_ratio_seq(npulse);
        len_time_seq=length(time_seq);
        hami_list=cell(1,len_time_seq);
        p_list=(1:len_time_seq)+npulse;
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
end

function time_seq= time_ratio_seq(npulse)
    if npulse==0
        time_seq=[-1,1];
    elseif npulse>0
        nsegment=npulse+1;
        step=1/npulse/2;
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
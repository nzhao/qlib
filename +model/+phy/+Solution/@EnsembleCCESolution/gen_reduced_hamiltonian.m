function reduced_hami = gen_reduced_hamiltonian(obj,cluster,hami_cluster)
%GEN_REDUCED_HAMILTONIAN 
%  generate reduced hamiltonian for the given central spin states
    ts=model.phy.QuantumOperator.SpinOperator.TransformOperator(cluster,{'1.0 * eigenVectors()_1'});
    hami_cluster.transform(ts);

    CentralSpinStates=obj.parameters.SetCentralSpin.CentralSpinStates;
    hami1=hami_cluster.project_operator(1, CentralSpinStates(1));
    hami2=hami_cluster.project_operator(1, CentralSpinStates(2));
    hami1.remove_identity();
    hami2.remove_identity();
   
    if obj.parameters.IsSecularApproximation && hami1.spin_collection.getLength>1
        import model.phy.SpinApproximation.SpinSecularApproximation
        hami1.apply_approximation( SpinSecularApproximation(hami1.spin_collection) );
        hami2.apply_approximation( SpinSecularApproximation(hami2.spin_collection) );
    end
    
    reduced_hami=cell(1,2);
    reduced_hami{1,1}=hami1;
    reduced_hami{1,2}=hami2;
end


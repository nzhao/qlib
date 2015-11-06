function [hami, liou]=GetHamiltonianLiouvillian(obj, spin_collection)
    import model.phy.QuantumOperator.SpinOperator.Hamiltonian
    import model.phy.SpinInteraction.ZeemanInteraction
    import model.phy.SpinInteraction.DipolarInteraction
    import model.phy.SpinApproximation.SpinSecularApproximation

    para=obj.parameters;

    hami=Hamiltonian(spin_collection);
    hami.addInteraction( ZeemanInteraction(spin_collection) );
    hami.addInteraction( DipolarInteraction(spin_collection) );

    if para.IsSecularApproximation
        hami.apply_approximation( SpinSecularApproximation(spin_collection) );
    end
    %liou=hami.circleC();            
end
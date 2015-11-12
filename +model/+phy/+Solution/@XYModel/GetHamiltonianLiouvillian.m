function [hami, liou]=GetHamiltonianLiouvillian(obj, spin_collection)
    import model.phy.QuantumOperator.SpinOperator.Hamiltonian
    import model.phy.SpinInteraction.OnSiteEnergy
    import model.phy.SpinInteraction.XYchainInteraction
    %para=obj.parameters;

    hami=Hamiltonian(spin_collection);
    hami.addInteraction( OnSiteEnergy(spin_collection, 'uniform', 1.0));
    hami.addInteraction( XYchainInteraction(spin_collection, 'uniform', 2.0));

    if strcmp(obj.parameters.InitialStateType, 'MixedState')
        liou=hami.circleC();
    else
        liou=[];
    end
end
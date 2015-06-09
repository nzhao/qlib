function obs=GetObservables(obj, spin_collection)
    import model.phy.QuantumOperator.SpinOperator.Observable
    para=obj.parameters;

    obs=cell(1, para.ObservableNumber);
    for k=1:para.ObservableNumber
        obs{k}=Observable(spin_collection, para.ObservableName{k}, para.ObservableString{k});
    end

end
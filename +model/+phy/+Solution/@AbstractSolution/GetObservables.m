function obs=GetObservables(obj, spin_collection,matrix_strategy)
    import model.phy.QuantumOperator.SpinOperator.Observable
    para=obj.parameters;
    if nargin < 2
       matrix_strategy=model.phy.QuantumOperator.MatrixStrategy.FromProductSpace(); 
    end
    obs=cell(1, para.ObservableNumber);
    for k=1:para.ObservableNumber
        obs{k}=Observable(spin_collection,matrix_strategy, para.ObservableName{k}, para.ObservableString{k});
    end

end
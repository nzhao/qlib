function initstate=GetDensityMatrix(obj, spin_collection)
    import model.phy.QuantumOperator.SpinOperator.DensityMatrix
    import model.phy.SpinStateVector.SpinStateVector
    import model.phy.SpinStateVector.VectorStrategy.EigenBasis
    para=obj.parameters;
    if strcmp(para.InitialStateType, 'MixedState')
        initstate=DensityMatrix(spin_collection, para.InitialState);
    else
        initstate=SpinStateVector(EigenBasis(spin_collection, 2));
    end
end
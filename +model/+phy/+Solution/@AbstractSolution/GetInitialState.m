function initstate=GetInitialState(obj, spin_collection)
    import model.phy.QuantumOperator.SpinOperator.DensityMatrix
    import model.phy.SpinStateVector.SpinStateVector
    import model.phy.SpinStateVector.VectorStrategy.EigenBasis
    para=obj.parameters;
    if strcmp(para.InitialStateType, 'MixedState')
        initstate=DensityMatrix(spin_collection, para.InitialState);
    elseif strcmp(para.InitialStateType, 'PureState')
        initstate=SpinStateVector(EigenBasis(spin_collection, para.InitialState));
    else
        error('InitialStateType "%s" is not supported.', para.InitialStateType);
    end
end
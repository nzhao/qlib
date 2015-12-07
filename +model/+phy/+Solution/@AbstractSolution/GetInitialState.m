function initstate=GetInitialState(obj, spin_collection,strategy)
    import model.phy.QuantumOperator.SpinOperator.DensityMatrix
    import model.phy.SpinStateVector.SpinStateVector
    import model.phy.SpinStateVector.VectorStrategy.EigenBasis
    import model.phy.QuantumOperator.MatrixStrategy.FromKronProd
    import model.phy.QuantumOperator.MatrixStrategy.FromProductSpace
    para=obj.parameters;
    if nargin<3
          strategy=FromKronProd;
    end
    if strcmp(para.InitialStateType, 'MixedState')
        initstate=DensityMatrix(spin_collection,strategy, para.InitialState);
    elseif strcmp(para.InitialStateType, 'PureState')
        initstate=SpinStateVector(EigenBasis(spin_collection, para.InitialState));
    else
        error('InitialStateType "%s" is not supported.', para.InitialStateType);
    end
end
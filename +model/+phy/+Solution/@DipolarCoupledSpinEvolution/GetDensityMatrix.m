function denseMat=GetDensityMatrix(obj, spin_collection)
    import model.phy.QuantumOperator.SpinOperator.DensityMatrix
    para=obj.parameters;
    denseMat=DensityMatrix(spin_collection, para.InitialState);
end
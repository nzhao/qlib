classdef EigenBasis < model.phy.SpinStateVector.VectorStrategy.AbstractVectorStrategy
    %EIGENBASIS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nonzero_idx
    end
    
    methods
        function obj=EigenBasis(spin_collection, n)
            obj@model.phy.SpinStateVector.VectorStrategy.AbstractVectorStrategy(spin_collection);
            obj.nonzero_idx=n;
        end
        
        function vector=calculate_vector(obj)
            dim=obj.spin_collection.getDim();
            vector=zeros(dim, 1);
            vector(obj.nonzero_idx)=1;
        end
    end
    
end


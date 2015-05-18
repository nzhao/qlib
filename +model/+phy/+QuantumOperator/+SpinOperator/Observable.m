classdef Observable < model.phy.QuantumOperator.MultiSpinOperator
    %DENSITYMATRIX Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=Observable(spin_collection, matrix_strategy)
            obj@model.phy.QuantumOperator.MultiSpinOperator(spin_collection);
            if nargin > 1
                obj.matrix_strategy = matrix_strategy;
            end

        end
        
        function v=vector(obj)
            v=obj.matrix(:);
        end
        
    end
    
end


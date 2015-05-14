classdef DensityMatrix < model.phy.QuantumOperator.Hamiltonian
    %DENSITYMATRIX Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=DensityMatrix(spin_collection, matrix_strategy)
            if nargin < 2
                matrix_strategy=model.phy.QuantumOperator.MatrixStrategy.FromProductSpace();
            end
            obj@model.phy.QuantumOperator.Hamiltonian(spin_collection, matrix_strategy);
        end
        
        function addSpinOrder(obj, spinOrder)
            obj.addInteraction(spinOrder);
        end
        
        function v=vector(obj)
            v=obj.matrix(:);
        end
    end
    
end


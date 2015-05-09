classdef DensityMatrix < model.phy.QuantumOperator.Hamiltonian
    %DENSITYMATRIX Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=DensityMatrix(spin_collection)
            obj@model.phy.QuantumOperator.Hamiltonian(spin_collection);
        end
        
        function addSpinOrder(obj, spinOrder)
            obj.addInteraction(spinOrder);
        end
    end
    
end


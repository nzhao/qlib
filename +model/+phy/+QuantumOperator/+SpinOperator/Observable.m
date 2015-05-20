classdef Observable < model.phy.QuantumOperator.MultiSpinOperator
    %DENSITYMATRIX Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=Observable(name, spin_collection, spin_index, spin_mat_str, spin_coeff)
            obj@model.phy.QuantumOperator.MultiSpinOperator(spin_collection);
            obj.setName(name);
            
            if nargin < 5
                spin_coeff = num2cell(ones(1, length(spin_index)));
            end
            
            spin_interaction=model.phy.SpinInteraction.SpinInteraction(spin_collection, spin_index, spin_mat_str, spin_coeff);
            obj.addInteraction(spin_interaction);
            
            
        end
        
    end
    
end


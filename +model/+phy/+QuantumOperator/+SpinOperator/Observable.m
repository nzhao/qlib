classdef Observable < model.phy.QuantumOperator.MultiSpinOperator
    %DENSITYMATRIX Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=Observable(spin_collection, name, str)
            obj@model.phy.QuantumOperator.MultiSpinOperator(spin_collection);
            if nargin > 1
                obj.setName(name);
                obj.addInteraction(model.phy.SpinInteraction.InteractionString(spin_collection, str));
            end
            
        end
        
    end
    
end


classdef TransformOperator < model.phy.QuantumOperator.MultiSpinOperator
    %TRANSFORMOPERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=TransformOperator(spin_collection, str)
            obj@model.phy.QuantumOperator.MultiSpinOperator(spin_collection);
            if nargin > 1
                obj.addInteraction(model.phy.SpinInteraction.InteractionString(spin_collection, str));
            end
            
        end

    end
    
end


classdef Observable < model.phy.QuantumOperator.MultiSpinOperator
    %DENSITYMATRIX Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=Observable(name, spin_collection, str)
            obj@model.phy.QuantumOperator.MultiSpinOperator(spin_collection);
            obj.setName(name);
            
            interaction_string=model.phy.SpinInteraction.InteractionString(spin_collection, str);
            spin_interaction=interaction_string.getInteraction();
            obj.addInteraction(spin_interaction);
            
            
        end
        
    end
    
end


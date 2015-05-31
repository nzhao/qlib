classdef LocalFieldZeemanInteraction < model.phy.SpinInteraction.ZeemanInteraction
    %LOCALFIELDZEEMANINTERACTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        local_fields
    end
    
    methods
        function obj=LocalFieldZeemanInteraction(spin_collection, local_fields)
            obj@model.phy.SpinInteraction.ZeemanInteraction(spin_collection);
            obj.local_fields=local_fields;
            for k=1:spin_collection.getLength
                spin_collection.spin_list{k}.local_field=local_fields(k, :);
            end
        end
        
        function coeff=calculate_coeff(~, spin)
            coeff=spin.local_field * spin.gamma;
        end

    end
    
end


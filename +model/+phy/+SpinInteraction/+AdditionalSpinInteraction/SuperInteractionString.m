classdef SuperInteractionString  < model.phy.SpinInteraction.AdditionalSpinInteraction.InteractionString
    %SUPERINTERACTIONSTRING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=SuperInteractionString(spin_collection, str)
            obj@model.phy.SpinInteraction.AdditionalSpinInteraction.InteractionString(spin_collection, str);            
        end
        
        function skp=single_skp_term(obj)
            cursor=obj.iter.cursor;
            coeff=obj.parameter.spin_coeff{cursor};
            mat_kp=obj.parameter.spin_mat{cursor}; 
            skp=coeff*mat_kp;
        end
    end
    
end


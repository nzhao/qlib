classdef SpinInteraction < model.phy.SpinInteraction.GeneralSpinInteraction
    %SPINORDER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=SpinInteraction(spin_collection, spin_index, spin_mat_str, spin_coeff)
            if nargin < 4
                spin_coeff = num2cell(ones(1, length(spin_index)));
            end
            
            new_mat=spin_collection.calc_mat(spin_index, spin_mat_str);
            obj@model.phy.SpinInteraction.GeneralSpinInteraction(spin_collection, spin_index, new_mat, spin_coeff)
        end
        
    end
    
end




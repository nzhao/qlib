classdef SpinOrder < model.phy.SpinInteraction.SpinInteraction
    %SPINORDER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=SpinOrder(spin_collection, spin_index, spin_mat_str, spin_coeff)
            if nargin < 4
                spin_coeff = num2cell(ones(1, length(spin_index)));
            end
            
            new_coeff=coeff_normalization(spin_coeff);            
            obj@model.phy.SpinInteraction.SpinInteraction(spin_collection, spin_index, spin_mat_str, new_coeff)
        end
        
    end
    
end

function norm_coeff=coeff_normalization(spin_coeff)
    coeffmat=cell2mat(spin_coeff);
    norm=sum(coeffmat);
    if norm~=1.
        fprintf('Sum of coefficients=%d are normalizaed automatically.', norm);
    end
    norm_coeff=num2cell(coeffmat/norm);
end


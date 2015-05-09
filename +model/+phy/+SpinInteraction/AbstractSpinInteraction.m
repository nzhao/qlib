classdef AbstractSpinInteraction < handle
    %SPININTERACTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nbody
        parameter
        iter
    end
    
    methods
        function obj=AbstractSpinInteraction(para, iter)
            obj.parameter=para;
            obj.iter=iter;
        end
        
        function res=isConsistent(obj, spin_collection)
            res=(spin_collection==obj.iter.spin_collection);
        end
        
    end
    
    methods (Abstract)
        calculate_coeff(obj, item);
        calculate_matrix(obj);
    end
    
end


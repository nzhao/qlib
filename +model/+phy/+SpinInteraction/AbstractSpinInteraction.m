classdef AbstractSpinInteraction < handle
    %SPININTERACTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        parameter
        iter
    end
    
    methods
        function obj=AbstractSpinInteraction(iter, para)
            obj.parameter=para;
            obj.iter=iter;
        end
        
        function coeff_list=calculate_all(obj)
            coeff_list=cell(1, obj.iter.getLength);
            
            item=obj.iter.firstItem();
            coeff_list{1}=obj.calculate(item);
            while ~obj.iter.isLast()
                item=obj.iter.nextItem();
                cur=obj.iter.getCursor();
                coeff_list{cur}=obj.calculate(item);
            end
        end
    end
    
    methods (Abstract)
        calculate(obj, item);
    end
    
end


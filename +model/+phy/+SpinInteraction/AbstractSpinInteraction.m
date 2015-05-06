classdef AbstractSpinInteraction < handle
    %SPININTERACTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nbody
        parameter
        iter
    end
    
    methods
        function obj=AbstractSpinInteraction(iter, para)
            obj.parameter=para;
            obj.iter=iter;
        end
        
%         function matrix=matrix(obj)
%             matrix=sparse(0);
%             
%             obj.iter.setCursor(1);
%             matrix=matrix+obj.matrix_term();
%             while ~obj.iter.isLast()
%                 obj.iter.moveForward();
%                 matrix=matrix+obj.matrix_term();
%             end
%         end
%         
%         function matrix=matrix_term(obj)
%             index=obj.iter.currentIndex;
%             sub_mat=obj.calculate_sub_matrix(obj.iter.currentItem);
%             spin_collection=obj.iter.spin_collection;
%             matrix=model.phy.SpinInteraction.compute_matrix(spin_collection, index, sub_mat);
%         end
    end
    
    methods (Abstract)
        calculate_coeff(obj, item);
        calculate_matrix(obj, item);
    end
    
end


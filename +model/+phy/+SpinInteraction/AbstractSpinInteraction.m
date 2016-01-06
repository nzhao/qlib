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
        
        function kp=kron_prod(obj, coeff, idx, mat)
            len=length(idx);          
            dim_list1= obj.iter.spin_collection.dim_compression(idx);
            mat_cell1 = num2cell(ones(1, 2*len+1));
            for ii=1:len
                mat_cell1{2*ii}=mat{ii};
            end

            dim_list=dim_list1(dim_list1>1);
            mat_cell=mat_cell1(dim_list1>1);
            kp=KronProd(mat_cell, fliplr(1:length(mat_cell)), fliplr(dim_list), coeff);            
        end
        
        function skp=skp_form(obj)
            obj.iter.setCursor(1);
            skp=obj.single_skp_term;
            while ~obj.iter.isLast()   
                obj.iter.moveForward();
                skp=skp+obj.single_skp_term();
            end
        end
    end
    
    methods (Abstract)
        calculate_coeff(obj, item);
        calculate_matrix(obj);
        %data_cell(obj);
    end
    
end


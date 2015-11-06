classdef GeneralSpinInteraction < model.phy.SpinInteraction.AbstractSpinInteraction
    %INDIVIDUALSPINORDER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dim_list
    end
    
    methods
        function obj=GeneralSpinInteraction(spin_collection, spin_index, spin_mat, spin_coeff)
            para.spin_index=spin_index;
            para.spin_mat=spin_mat;
            para.spin_coeff=spin_coeff;
            if ~(length(spin_index)==length(spin_mat) && length(spin_index)==length(spin_coeff))
                error('Not Equal length.');
            end
            iter=model.phy.SpinCollection.Iterator.SpinIterator(spin_collection, spin_index);
            obj@model.phy.SpinInteraction.AbstractSpinInteraction(para, iter);
            obj.dim_list=obj.iter.spin_collection.getDimList;
        end
        
        function coeff=calculate_coeff(obj)
            coeff=obj.parameter.spin_coeff{obj.iter.getCursor};
        end
        
        function mat=calculate_matrix(obj)
            coeff=obj.calculate_coeff();
            matCell=obj.parameter.spin_mat{obj.iter.getCursor};
            lenMat=length(matCell);
            
            mat1=1;
            for k=1:lenMat
                mat1=kron(mat1, matCell{k});
            end
            mat=coeff*mat1;
        end
    end
    
end


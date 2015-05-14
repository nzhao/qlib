classdef SpinOrder < model.phy.SpinInteraction.AbstractSpinInteraction
    %INDIVIDUALSPINORDER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dim_list
    end
    
    methods
        function obj=SpinOrder(spin_collection, spin_index_list, spin_order_list)
            para.spin_index=spin_index_list;
            para.spin_order=spin_order_list;
            iter=model.phy.SpinCollection.Iterator.SpinIterator(spin_collection, spin_index_list);
            obj@model.phy.SpinInteraction.AbstractSpinInteraction(para, iter);
            obj.dim_list=obj.iter.spin_collection.getDimList;
        end
        
        function coeff=calculate_coeff(obj)
            sel=obj.parameter.spin_index(obj.iter.currentIndex);
            total_dim=prod(obj.dim_list);
            coeff=1.0 / (total_dim/obj.dim_list(sel));
        end
        
        function mat=calculate_matrix(obj)
            coeff=obj.calculate_coeff();
            mat1=obj.parameter.spin_order{obj.iter.currentIndex};
            mat=coeff*mat1/trace(mat1);
        end
    end
    
end


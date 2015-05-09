classdef SpinOrder < model.phy.SpinInteraction.AbstractSpinInteraction
    %INDIVIDUALSPINORDER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=SpinOrder(spin_collection, spin_index_list, spin_order_list)
            para.spin_index=spin_index_list;
            para.spin_order=spin_order_list;
            iter=model.phy.SpinCollection.Iterator.SpinIterator(spin_collection, spin_index_list);
            obj@model.phy.SpinInteraction.AbstractSpinInteraction(para, iter);
        end
        
        function calculate_coeff()
        end;
        function mat=calculate_matrix(obj)
            mat=obj.parameter.spin_order{obj.iter.currentIndex};
        end
    end
    
end


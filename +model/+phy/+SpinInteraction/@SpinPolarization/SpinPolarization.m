classdef SpinPolarization < model.phy.SpinInteraction.AbstractSpinInteraction
    %ONESPINORDER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=SpinPolarization(spin_collection, polarization_direction)
            parameter.polarization_direction=polarization_direction;
            iter=model.phy.SpinCollection.Iterator.SingleSpinIterator(spin_collection);
            obj@model.phy.SpinInteraction.AbstractSpinInteraction(parameter, iter);
            obj.nbody=1;
        end
        
        function calculate_coeff()
        end;        
        
        function mat=calculate_matrix(obj)
            spin=obj.iter.currentItem{1};
            pol=obj.parameter.polarization_direction;
            mat=pol(1)*spin.sx+...
                pol(2)*spin.sy+...
                pol(3)*spin.sz;
        end
    end
    
end


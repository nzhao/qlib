classdef ZeemanInteraction < model.phy.SpinInteraction.AbstractSpinInteraction
    %ZEEMANINTERACTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=ZeemanInteraction(spin_collection, parameter, iter)
            if nargin < 3
                iter=model.phy.SpinCollection.Iterator.SingleSpinIterator(spin_collection);
            end
            obj@model.phy.SpinInteraction.AbstractSpinInteraction(parameter, iter);
            obj.nbody=1;
        end
        
        function coeff=calculate_coeff(obj, spin)
            coeff=obj.parameter.B * spin.gamma;
        end
        function mat=calculate_matrix(obj)
            spin=obj.iter.currentItem{1};
            coeff=obj.calculate_coeff(spin);
            mat=coeff*spin.sz;
        end
    end
    
end


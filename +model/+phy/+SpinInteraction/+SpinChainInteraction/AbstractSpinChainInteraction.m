classdef AbstractSpinChainInteraction < model.phy.SpinInteraction.AbstractSpinInteraction
    %SPINCHAININTERACTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=AbstractSpinChainInteraction(spin_collection, para, iter)
            obj@model.phy.SpinInteraction.AbstractSpinInteraction(para, iter);
        end

        function coeff=calculate_coeff(obj, spins)
            spin1=spins{1}; 
            spin_idx=str2double(spin1.name);
            coeff=obj.parameter.interaction(spin_idx);
        end
        
        function mat=calculate_matrix(obj)
            spins=obj.iter.currentItem();
            spin1=spins{1}; spin2=spins{2};
            coeff=obj.calculate_coeff(spins);
            mat= coeff*kron(spin1.sx,spin2.sx)...
                +coeff*kron(spin1.sy,spin2.sy);
        end
        
    end
    
end


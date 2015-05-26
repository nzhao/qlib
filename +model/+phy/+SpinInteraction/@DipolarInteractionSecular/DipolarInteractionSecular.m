classdef DipolarInteractionSecular < model.phy.SpinInteraction.DipolarInteraction
    %DIPOLARINTERACTIONSECULAR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=DipolarInteractionSecular(spin_collection, para, iter)
            if nargin < 3
                iter=model.phy.SpinCollection.Iterator.PairSpinIterator(spin_collection);
            end

            obj@model.phy.SpinInteraction.DipolarInteraction(spin_collection, para, iter);
        end
                
        function mat=calculate_matrix(obj)
            spins=obj.iter.currentItem();
            spin1=spins{1}; spin2=spins{2};
            dip=obj.calculate_coeff(spins);
            
            if strcmp(spin1.name, spin2.name)
                mat= dip(3, 3)*...
                    (-0.5*kron(spin1.sx,spin2.sx)...
                     -0.5*kron(spin1.sy,spin2.sy)...
                         +kron(spin1.sz,spin2.sz));
            else
                mat= dip(3, 3)*kron(spin1.sz,spin2.sz);
            end
        end

    end
    
end


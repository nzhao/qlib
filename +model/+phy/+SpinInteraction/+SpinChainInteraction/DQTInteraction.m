classdef DQTInteraction < model.phy.SpinInteraction.SpinChainInteraction.AbstractSpinChainInteraction
    %DQTINTERACTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=DQTInteraction(spin_collection, para)
            iter=model.phy.SpinCollection.Iterator.ChainNeighbouringIterator(spin_collection);
            obj@model.phy.SpinInteraction.SpinChainInteraction.AbstractSpinChainInteraction(spin_collection, para, iter);
            obj.nbody=2;
        end
        
        function mat=calculate_matrix(obj)
            spins=obj.iter.currentItem();
            spin1=spins{1}; spin2=spins{2};
            coeff=obj.calculate_coeff(spins);
            mat= coeff*kron(spin1.sx,spin2.sx)...
                -coeff*kron(spin1.sy,spin2.sy);
        end
        
        function dataCell=data_cell(obj)
            nPair=obj.iter.getLength;
            nTerms=nPair*2;
            dataCell=cell(1, nTerms);
            
            obj.iter.setCursor(1);
            for ii=1:nPair
                spins=obj.iter.currentItem();
                spin_idx=obj.iter.currentIndex();
                spin1=spins{1}; spin2=spins{2};
                index1=spin_idx(1); index2=spin_idx(2);
                
                coeff=obj.calculate_coeff(spins);
                
                dataCell{(ii-1)*2+1}={coeff, obj.nbody, ...
                    index1, spin1.dim, reshape(spin1.sx, [], 1), ...
                    index2, spin2.dim, reshape(spin2.sx, [], 1)
                    };
                dataCell{(ii-1)*2+2}={-coeff, obj.nbody, ...
                    index1, spin1.dim, reshape(spin1.sy, [], 1), ...
                    index2, spin2.dim, reshape(spin2.sy, [], 1)
                    };
                obj.iter.nextItem;
            end
        end
    end
    
end


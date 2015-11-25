classdef OnSiteEnergy < model.phy.SpinInteraction.SpinChainInteraction.AbstractSpinChainInteraction
    %ONSITEENERGY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=OnSiteEnergy(spin_collection,para)
            iter=model.phy.SpinCollection.Iterator.SingleSpinIterator(spin_collection);
            obj@model.phy.SpinInteraction.SpinChainInteraction.AbstractSpinChainInteraction(spin_collection, para, iter);
            obj.nbody=1;
        end

        function skp=single_skp_term(obj)
            spin=obj.iter.currentItem{1};
            coeff=obj.calculate_coeff({spin});
            idx=obj.iter.currentIndex();
            
            mat=spin.sz;
            skp=obj.kron_prod(coeff, idx, {mat});
        end
        
        function mat=calculate_matrix(obj)
            spin=obj.iter.currentItem{1};
            coeff=obj.calculate_coeff({spin});
            mat=coeff*spin.sz;
        end
        
        function dataCell=data_cell(obj)
            nTerms=obj.iter.getLength;
            dataCell=cell(1, nTerms);
            
            obj.iter.setCursor(1);
            for ii=1:nTerms
                spin=obj.iter.currentItem{1};
                spin_idx=obj.iter.currentIndex;

                mat=obj.calculate_matrix();
                
                dataCell{ii}={1.0, obj.nbody, spin_idx, spin.dim, reshape(mat, [], 1)};
                obj.iter.nextItem;
            end
        end
    end
    
end


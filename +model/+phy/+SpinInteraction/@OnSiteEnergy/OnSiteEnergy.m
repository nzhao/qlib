classdef OnSiteEnergy < model.phy.SpinInteraction.AbstractSpinInteraction
    %ONSITEENERGY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=OnSiteEnergy(spin_collection, method, val)
            nspin=spin_collection.getLength;
            iter=model.phy.SpinCollection.Iterator.SingleSpinIterator(spin_collection);
            switch method
                case 'uniform'
                    para.energy=val*ones(1, nspin);
                case 'random'
                    lo=val(1); hi=val(2); d=hi-lo;
                    para.energy=d*rand(1, nspin)-lo;
                otherwise
                    error('%s is not supported', method);
            end
            obj@model.phy.SpinInteraction.AbstractSpinInteraction(para, iter);
            obj.nbody=1;
        end
        
        function coeff=calculate_coeff(obj, spin)
            spin_idx=str2double(spin.name);
            coeff=obj.parameter.energy(spin_idx);
        end
        
        function mat=calculate_matrix(obj)
            spin=obj.iter.currentItem{1};
            coeff=obj.calculate_coeff(spin);
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


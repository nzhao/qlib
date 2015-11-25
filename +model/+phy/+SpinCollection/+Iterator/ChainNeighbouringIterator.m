classdef ChainNeighbouringIterator < model.phy.SpinCollection.SpinCollectionIterator
    %CHAINNEIGHBOURITERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=ChainNeighbouringIterator(spin_collection)
            obj@model.phy.SpinCollection.SpinCollectionIterator(spin_collection);
        end
        function res = index_gen(obj)
            nspin=obj.spin_collection.getLength();
            res=cell(nspin-1, 1);
            for ii=1:nspin-1
                res{ii}=[ii, ii+1];
            end
        end
    end
    
end


classdef PairSpinIterator < model.phy.SpinCollection.SpinCollectionIterator
    %PAIRSPINITERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = PairSpinIterator(spin_collection)
            obj@model.phy.SpinCollection.SpinCollectionIterator(spin_collection);
        end
        function res = index_gen(obj)
            singleIdx = 1:obj.spin_collection.getLength();
            resMat=flipud(combnk(singleIdx, 2));
            res=mat2cell(resMat, ones(1, length(resMat)), 2);
        end
    end
    
end


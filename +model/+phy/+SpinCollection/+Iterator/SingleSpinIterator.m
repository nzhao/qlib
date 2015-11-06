classdef SingleSpinIterator < model.phy.SpinCollection.SpinCollectionIterator
    %SINGLESPINITERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = SingleSpinIterator(spin_collection)
            obj@model.phy.SpinCollection.SpinCollectionIterator(spin_collection);
        end
        function res = index_gen(obj)
            res = 1:obj.spin_collection.getLength();
            res = num2cell(res');
        end
    end
    
end


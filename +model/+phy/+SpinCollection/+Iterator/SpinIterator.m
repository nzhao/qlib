classdef SpinIterator < model.phy.SpinCollection.SpinCollectionIterator
    %INDIVIDUALSPINITERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = SpinIterator(spin_collection, spin_index_list)
            obj@model.phy.SpinCollection.SpinCollectionIterator(spin_collection);
            obj.index_list = spin_index_list;
        end
        function res = index_gen(obj)
            res = obj.index_list;
        end
    end
    
end


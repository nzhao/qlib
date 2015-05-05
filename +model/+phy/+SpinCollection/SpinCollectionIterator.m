classdef SpinCollectionIterator < handle
    %SPINCOLLECTIONITERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_list
        index_list
        current
    end
    
    methods
        function obj=SpinCollectionIterator(spin_collection)
            obj.spin_list = spin_collection.spin_list;
            obj.index_list = obj.index_gen(spin_collection);
            obj.current = 1;
        end
        
        function res = index_gen(obj, spin_collection)
            res=1: spin_collection.getLength;
        end
        
        function res = first(obj)
            first_index = obj.index_list(1);
            res = obj.spin_list{first_index};
        end
        function res = next(obj)
            next_index = obj.index_list(obj.current+1);
            res = obj.spin_list{next_index};
        end
        function res = currentItem(obj)
            res =  obj.spin_list{obj.current};
        end
        function res = hasNext(obj)
            res = (obj.current==length(obj.index_list));
        end
    end
    
end


classdef ClusterIterator < model.phy.SpinCollection.SpinCollectionIterator
    %CLUSTERITERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        parameters
    end
    
    methods
        function obj = ClusterIterator(spin_collection, strategy)
            obj@model.phy.SpinCollection.SpinCollectionIterator(spin_collection, strategy);
        end
        
        function res = index_gen(obj)
            res=obj.index_generator.generate_clusters();
        end
    end
    
end


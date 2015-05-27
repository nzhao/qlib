classdef ClusterIterator < model.phy.SpinCollection.SpinCollectionIterator
    %CLUSTERITERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        clustering_strategy
        parameters
    end
    
    methods
        function obj = ClusterIterator(spin_collection, strategy, parameters)
            obj@model.phy.SpinCollection.SpinCollectionIterator(spin_collection);
            obj.clustering_strategy=strategy;
            obj.parameters=parameters;
        end
        
        function res = index_gen(obj)
            res=obj.clustering_strategy.generate_clusters(obj.parameters);
        end
    end
    
end


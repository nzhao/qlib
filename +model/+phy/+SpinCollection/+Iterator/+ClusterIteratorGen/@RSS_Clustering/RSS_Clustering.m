classdef RSS_Clustering < model.phy.SpinCollection.Iterator.ClusterIteratorGen.AbstractClusterIteratorGen
    %CCE_CLUSTERING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods
        function obj=RSS_Clustering(spin_collection, parameters)
            obj@model.phy.SpinCollection.Iterator.ClusterIteratorGen.AbstractClusterIteratorGen(spin_collection, parameters);
        end
        function cluster_list=generate_clusters(obj)
            cluster_list=obj.generate_cluster_list();
            obj.cluster_info.state_list=obj.generate_state_list();            
        end
    end
end


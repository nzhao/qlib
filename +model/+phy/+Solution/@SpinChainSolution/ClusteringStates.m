function cluster_iterator = ClusteringStates(obj)
%CLUSTERSTATE Summary of this function goes here
%   Detailed explanation goes here
    import model.phy.SpinCollection.Iterator.ClusterIterator
    import model.phy.SpinCollection.Iterator.ClusterIteratorGen.RSS_Clustering
    
    
    para=obj.parameters;
    if para.load_cluster_iter             
      cluster_iterator=obj.keyVariables('cluster_iterator');
    else             
       spin_collection=obj.keyVariables('spin_collection');
       clu_para.cutoff=para.CutOff;
       clu_para.max_order=para.MaxOrder;
       
       disp('clustering begins...')
       tic
       rss=RSS_Clustering(spin_collection, clu_para);
       cluster_iterator=ClusterIterator(spin_collection,rss);
       obj.keyVariables('cluster_iterator')=cluster_iterator;
       save([OUTPUT_FILE_PATH, 'cluster_iterator', obj.timeTag, '.mat'],'cluster_iterator');
       toc
    end
end


function CoherenceTotal(obj)   
   import model.phy.SpinCollection.SpinCollection   
   import model.phy.SpinCollection.Strategy.FromSpinList
   
   para=obj.parameters;
   cluster_collection=obj.keyVariables('cluster_collection');
  
   CoherenceMatrix=zeros(cluster_collection.cluster_info.cluster_number,para.NTime);
   ncluster=cluster_collection.cluster_info.cluster_number;
   
   disp('calculate the cluster-coherence matrix ...');
   tic
   for n=1:ncluster
        coh=obj.ClusterCoherence(n);
        CoherenceMatrix(n,:)=coh;
    end
    obj.keyVariables('cluster_coherence_matrix')=CoherenceMatrix;
    toc
    disp('calculation of the cluster-coherence matrix finished.');
   
    subcluster_list=cluster_collection.cluster_info.subcluster_list;
    cluster_number_list=[cluster_collection.cluster_info.cluster_number_list{:,2}];
    [coherence,coh_tilde_mat]=CoherenceTilde(CoherenceMatrix,subcluster_list,cluster_number_list);
    obj.keyVariables('cluster_coherence_tilde_Matrix')=coh_tilde_mat;
    coherence.timelist=para.TimeList;
    obj.keyVariables('coherence')=coherence;
end

function [coherence, coh_tilde_mat]=CoherenceTilde(cohmat,subcluster_list,cluster_number_list)

    
    nclusters=length(subcluster_list);
    ntime=length(cohmat(1,:));
    coh_tilde_mat=zeros(nclusters,ntime);
    coh_total=ones(1,ntime);
    cceorder=1;
    endpoints=cumsum(cluster_number_list);
    for m=1:nclusters
        subcluster=subcluster_list{m};
        nsubcluster=length(subcluster);
        coh_tilde=cohmat(m,:);
        if nsubcluster==0
            coh_tilde_mat(m,:)= coh_tilde;
        elseif nsubcluster>0
            for n=1:nsubcluster;
                coh_tilde_sub=coh_tilde_mat(subcluster(n),:);
                coh_tilde=coh_tilde./coh_tilde_sub;
            end
            coh_tilde_mat(m,:)=coh_tilde;
        end

        coh_total=coh_total.*coh_tilde;
        if m==endpoints(1,cceorder)
            field_name=strcat('coherence_cce_',num2str(cceorder));
            coherence.(field_name)=coh_total;
            cceorder=cceorder+1;
        end
    end
    coherence.('coherence')= coh_total; 
end

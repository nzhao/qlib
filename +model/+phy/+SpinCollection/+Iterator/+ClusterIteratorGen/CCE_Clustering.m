classdef CCE_Clustering < model.phy.SpinCollection.Iterator.ClusterIteratorGen.AbstractClusterIteratorGen
    %CCE_CLUSTERING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=CCE_Clustering(spin_collection, parameters)
            obj@model.phy.SpinCollection.Iterator.ClusterIteratorGen.AbstractClusterIteratorGen(spin_collection, parameters);
        end
        
        function idx_list=generate_clusters(obj)
            disp('cluster_matrix_gen: building the clusters...');
            nspin=obj.spin_collection.getLength();
            maxorder=obj.parameters.max_order;
            
            cluster_list=eye(nspin);
            for n=1:(maxorder-1)
                fprintf('generating clusters of order n=%d ...\n', n+1);
                neighbor_matrix=logical(cluster_list*obj.connection_matrix); neighbor_matrix(logical(cluster_list))=0;
                new_cluster_list_size=nnz(neighbor_matrix)+nnz(sum(neighbor_matrix,2)==0);
                new_cluster_list=zeros(new_cluster_list_size,nspin);%,new_cluster_list_size*(n+1)
                pos=1;
                for k=1:size(cluster_list,1)
                    spins_to_add=find(neighbor_matrix(k,:));
                    if isempty(spins_to_add)
                        new_cluster_list(pos,:)=cluster_list(k,:);
                        pos=pos+1;
                    else
                        for m=spins_to_add
                            new_cluster_list(pos,:)=cluster_list(k,:);
                            new_cluster_list(pos,m)=1;
                            pos=pos+1;
                        end
                    end
                end

                   cluster_list=unique([cluster_list;new_cluster_list],'rows');
            end
            obj.cluster_matrix=cluster_list;
            disp('cluster matrix generated');
            [nc, ~]=size(obj.cluster_matrix);
            
            obj.sort_cluster();
            idx_list=cell(nc, 1);
            for k=1:nc
                idx_list{k}=find(obj.cluster_matrix(k,:));
            end
        end
        function sort_cluster(obj)
            cluster_list=obj.cluster_matrix;
            [nrow,ncol]=size(cluster_list);
            nz_list=zeros(nrow,1);%none zero list of state list
            for n=1:nrow
                nz_list(n,1)=nnz(cluster_list(n,:));
            end

            A=[cluster_list,nz_list];
            cols=fliplr(1:(ncol+1));
            A=sortrows(A,cols);
            cluster_list=A(:,1:ncol);
            obj.cluster_matrix=sparse(logical(cluster_list));
            obj.cluster_info.cluster_number=nrow;

            max_order=obj.parameters.max_order;
            nclu=cell(max_order,2);
            for n=1:max_order
            ncluster=length(find(nz_list==n));
            nclu{n,1}=['CCE-' num2str(n)];
            nclu{n,2}=ncluster;
            disp(['The number of ' num2str(n) '-spin clusters is: ' num2str(ncluster) '.']);               
            end
            obj.cluster_info.cluster_number_list=nclu; 
        end
        
        
    end

    
end


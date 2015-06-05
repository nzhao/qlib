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
            obj.cluster_info.subcluster_list=obj.generate_subclusters();
        end
        %% sort clusters        
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
        
         %%  Building the cluster-cluster cross-membership matrix and generate sub clusters
        function subcluster_list=generate_subclusters(obj)   
                disp('building subclusters list...');
                nclusters=obj.cluster_info.cluster_number;
                num_list=obj.cluster_info.cluster_number_list;%the end point of every order
                maxorder=obj.parameters.max_order;
                if maxorder==1
                    return;
                end
                row=ones((maxorder-1)*nclusters,1);
                col=ones((maxorder-1)*nclusters,1);
                val=zeros((maxorder-1)*nclusters,1);
                cluster_signatures=sum(obj.cluster_matrix,2);
                pos=0;clu_pointer=num_list{1,2};
                for cceorder=2:maxorder
                    %build the subclusters of current cce oeder
                    for n=(clu_pointer+1):(clu_pointer+num_list{cceorder,2})
                        one_col=ones(clu_pointer,1);
                        cluster_pattern=kron(obj.cluster_matrix(n,:),one_col);
                        cluster_credentials=sum(obj.cluster_matrix(1:clu_pointer,:).*cluster_pattern,2);
                        cluster_sign=cluster_signatures(1:clu_pointer,1);               
                        cols2add=find(cluster_credentials==cluster_sign);% the column index of the subclusters
                        n_sub_clu=length(cols2add);
                        rows2add=n*ones(n_sub_clu,1);
                        vals2add=ones(n_sub_clu,1);
                        row(pos+1:(pos+n_sub_clu),1)=rows2add;
                        col(pos+1:(pos+n_sub_clu),1)=cols2add;
                        val(pos+1:(pos+n_sub_clu),1)=vals2add;
                        pos=pos+n_sub_clu;
                    end
                    clu_pointer=clu_pointer+num_list{cceorder,2};
                end
               xmm=sparse(row,col,val,nclusters,nclusters);
               subcluster_list=cell(nclusters, 1);
                for k=1:nclusters
                    subcluster_list{k}=find(xmm(k,:));
                end
                disp('subcluster list generated');
        end
        
    end
end


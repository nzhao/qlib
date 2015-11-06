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
            disp(['The number of ' num2str(1) '-spin clusters is: ' num2str(nspin) '.']); 
            
            cluster_list_current=speye(nspin);
            
            cluster_list_cell=cell(maxorder,1);
            cluster_list_cell{1,1}=cluster_list_current;
            
            nclu=cell(maxorder,2);
            nclu{1,1}=['CCE-' num2str(1)];
            nclu{1,2}=nspin;
            
            for n=1:(maxorder-1)
                fprintf('generating clusters of order n=%d ...\n', n+1);

                neighbor_matrix=logical(cluster_list_current*obj.connection_matrix); neighbor_matrix(logical(cluster_list_current))=0;
                n_new_clusters=nnz(neighbor_matrix);
                nnz_new_cluster=n_new_clusters*(n+1);
                
                row_index=1;
                row=ones(nnz_new_cluster,1);
                col=ones(nnz_new_cluster,1);
                val=zeros(nnz_new_cluster,1);
                pos=1;
                for k=1:size(cluster_list_current,1)                    
                    spins_to_add=find(neighbor_matrix(k,:));
                    if isempty(spins_to_add)

                    else
                        for m=spins_to_add                           
                            row(pos:pos+n,1)=row_index*ones(n+1,1);                            
                            col_to_add=[find(cluster_list_current(k,:)),m]';
                            if length(col_to_add)~=(n+1)
                               error('the number of spins of the last order cluster is wrong'); 
                            end
                            col(pos:pos+n,1)=col_to_add;
                            val(pos:pos+n,1)=ones(n+1,1);
                            row_index=row_index+1;
                            pos=pos+n+1;
                        end
                    end                   
                end
                cluster_list_current=unique(sparse(row,col,val,n_new_clusters,nspin),'rows');
                ncluster=size(cluster_list_current,1);
                nclu{n+1,1}=['CCE-' num2str(n+1)];
                nclu{n+1,2}=ncluster;
                disp(['The number of ' num2str(n+1) '-spin clusters is: ' num2str(ncluster) '.']); 

                cluster_list_cell{n+1,1}=cluster_list_current;
            end
            
            obj.cluster_info.cluster_number_list=nclu;
            cluster_matrix=cell2mat(cluster_list_cell);
            obj.cluster_matrix=cluster_matrix;
            disp('cluster matrix generated');
            
            [nc, ~]=size(obj.cluster_matrix);
            obj.cluster_info.cluster_number=nc;
            idx_list=cell(nc, 1);
            for k=1:nc
                idx_list{k}=find(obj.cluster_matrix(k,:));
            end
            obj.cluster_info.subcluster_list=obj.generate_subclusters();
            
        end
         %%  Building the cluster-cluster cross-membership matrix and generate sub clusters
        function subcluster_list=generate_subclusters(obj)   
                disp('building subclusters list...');
                nclusters=obj.cluster_info.cluster_number;
                num_list=obj.cluster_info.cluster_number_list;%the end point of every order
                maxorder=obj.parameters.max_order;
                if maxorder==1
                    subcluster_list=cell(nclusters,1);
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


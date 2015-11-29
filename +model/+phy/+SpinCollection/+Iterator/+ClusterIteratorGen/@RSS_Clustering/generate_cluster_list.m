 function cluster_list=generate_cluster_list(obj)
    disp('cluster_matrix_gen: building the clusters...');
    nspin=obj.spin_collection.getLength();
    maxorder=obj.parameters.max_order;

    tic
    fprintf('generating 1-spin clusters...\n');
    cluster_list_current=speye(nspin);                                   
    for n=1:(maxorder-1)
        fprintf('generating %d-spin clusters of order...\n', n+1);

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
                row(pos:pos+n-1,1)=row_index*ones(n,1);                            
                col_to_add=find(cluster_list_current(k,:))';
                if length(col_to_add)~=n
                   error('the number of spins of the last order cluster is wrong'); 
                end
                col(pos:pos+n-1,1)=col_to_add;
                val(pos:pos+n-1,1)=ones(n,1);
                row_index=row_index+1;
                pos=pos+n;
                
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
    end

    ncluster=size(cluster_list_current,1);
    obj.cluster_info.cluster_number=ncluster;
    obj.cluster_info.cluster_matrix=cluster_list_current;
    disp('cluster matrix generated');
    toc
    
    cluster_list=cell(ncluster, 1);
    for k=1:ncluster
        cluster_list{k}=find(obj.cluster_info.cluster_matrix(k,:));
    end

end
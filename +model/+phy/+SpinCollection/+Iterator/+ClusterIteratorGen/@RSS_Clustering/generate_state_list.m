function state_list=generate_state_list(obj)
    % Generates state list. For each state generates cluster membership list.
    %% Building state lists 
    disp('statelist_gen: building state lists...');
    nspins=obj.spin_collection.getLength();
    dim_list=obj.spin_collection.getDimList();
    cluster_matrix=obj.cluster_info.cluster_matrix;
    cluster_number=obj.cluster_info.cluster_number;
    cluster_state_list=cell(1, cluster_number);

    %% generate the states cluster by cluster
    tic
    for n=1:cluster_number
        spins_involved=find(cluster_matrix(n,:));
        nstates=prod( dim_list(spins_involved) )^2;
        cluster_state_list{n}=spalloc(nstates,nspins,nstates*nnz(cluster_matrix(n,:)));   
        cluster_size=length(spins_involved);
        for k=1:cluster_size

            if k==1
                A=1;
            else
                A=ones(prod(dim_list(spins_involved(1:(k-1))))^2,1);
            end

            if k==cluster_size
                B=1;
            else
                B=ones(prod(dim_list(spins_involved((k+1):end)))^2,1);
            end
            cluster_state_list{n}(:,spins_involved(k))=kron(kron(A,(0:(dim_list(spins_involved(k))^2-1))'),B);       
        end
    end

    state_list=unique(vertcat(cluster_state_list{1:end}),'rows');%remove the same states
    state_list=sortrows(state_list);
    %%
    nstates=size(state_list,1);
    obj.cluster_info.nstates=nstates;
    disp(['statelist_gen: ' num2str(nstates) ' states generated.']);
    toc
end
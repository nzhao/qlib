function xmm=generate_xmm(obj)
    %XMM_GEN Summary of this function goes here
    %   Detailed explanation goes here

%% Building the state-cluster cross-membership matrix nstate-by-ncluster
    disp('building state-cluster cross-membership matrix...');
    tic
    nstates=obj.cluster_info.nstates;
    cluster_number=obj.cluster_info.cluster_number;
    cluster_matrix=obj.cluster_info.cluster_matrix;
    state_list=obj.cluster_info.state_list;

    row=ones(nstates,1);
    col=ones(nstates,1);
    val=zeros(nstates,1);
    pos=1;
    one_col=ones(nstates,1);
    for n=1:cluster_number
        cluster_pattern=kron(cluster_matrix(n,:),one_col);
        state_credentials=sum(state_list.*cluster_pattern,2);
        state_signatures=sum(state_list,2);
        xmm_val_col=find(state_credentials==state_signatures);
        len=length(xmm_val_col);
        row(pos:pos+len-1,1)=xmm_val_col;
        col(pos:pos+len-1,1)=n*ones(len,1);
        val(pos:pos+len-1,1)=ones(len,1);
        pos=pos+len;
    end
    
    
    xmm=sparse(row,col,val,nstates,cluster_number);
    toc
    
    state_belongs_to=cell(1, nstates);
    for n=1:nstates
        state_belongs_to{n}=find(xmm(n,:));
    end
    
    global_index_of_cluster_state=cell(1, cluster_number);
    for m=1:cluster_number
        global_index_of_cluster_state{m}=find(xmm(:,m))';
    end
    
%     obj.cluster_info.xmm=xmm;
    obj.cluster_info.state_belongs_to=state_belongs_to;
    obj.cluster_info.global_index_of_cluster_state=global_index_of_cluster_state;
    disp('state-cluster cross-membership matrix generated');



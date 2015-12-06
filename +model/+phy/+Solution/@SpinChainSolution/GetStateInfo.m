function [spin_num_list, probability_mat ] = GetStateInfo(obj, spin_collection,rho_vecs)
%GETSTATEINFO Summary of this function goes here
%   Detailed explanation goes here

    nspin=spin_collection.getLength;
    ts_superoperator= model.phy.QuantumOperator.SpinOperator.TransformSuperOperator(spin_collection);
    ts_mat=ts_superoperator.getMatrix;
    rho_vec_IST=ts_mat*rho_vecs;
    
    norm_factor=sqrt(rho_vecs(:,1)'*rho_vecs(:,1));
    [state_list_cell, probability_cell]=state_info(rho_vec_IST,nspin,norm_factor);    
    [spin_num_list,probability_mat]=cal_probability_mat(state_list_cell,probability_cell,nspin);
    
    obj.StoreKeyVariables(spin_num_list,probability_mat,state_list_cell,probability_cell);
end

function [state_list_cell,probability_cell]=state_info(states_IST,nspin,norm_factor)
    ntime=size(states_IST,2);
    state_list_cell=cell(1,ntime);
    probability_cell=cell(1,ntime);
    for m=1:ntime
        vec=states_IST(:,m);
        component_idx=find(vec>norm_factor*1e-6);
        vec_select=vec(component_idx)/norm_factor;
        [vec_sorted,ordering_idx]=sort(vec_select,'descend');
        component_idx=component_idx(ordering_idx);
        state_list_cell{m}=state_composition(component_idx,nspin);
        probability_cell{m}=vec_sorted.^2;
    end    
end


function state_list=state_composition(st_idx,nspin)           
    nstate=length(st_idx);
    row=ones(nstate,1);
    col=ones(nstate,1);
    val=zeros(nstate,1);
    pos=1;
    for kk=1:nstate
        idx=st_idx(kk);
        state_char=dec2base(idx-1,4,nspin);
        vec=zeros(1,nspin);
        for m=1:nspin
            vec(m)=str2double(state_char(m));%str2num
        end
        spin_idx=find(vec);
        nzeros=length(spin_idx);
        if isempty(spin_idx)
           row(pos:pos+nspin-1,1)=kk*ones(nspin,1);
           col(pos:pos+nspin-1,1)=(1:nspin)';
           val(pos:pos+nspin-1,1)=zeros(nspin,1);
           pos=pos+nspin;
        else
            row(pos:pos+nzeros-1,1)=kk*ones(nzeros,1);
            col(pos:pos+nzeros-1,1)=spin_idx';
            val(pos:pos+nzeros-1,1)=vec(spin_idx)';
            pos=pos+nzeros;
        end
    end
    state_list=sparse(row,col,val,nstate,nspin);            
end

function [spin_num_list,pro_mat]=cal_probability_mat(state_list_cell,probability_cell,nspin)
    ntime=length(state_list_cell);
    spin_num_list=0:nspin;
    pro_mat=zeros(nspin+1,ntime);
    for n=1:ntime
        state_list=state_list_cell{n};
        pro_list=probability_cell{n};
        
        nr=size(state_list,1);
        nz_list=zeros(nr,1);%none zero list of state list
        for k=1:nr
            nz_list(k,1)=nnz(state_list(k,:));
        end

        for kk=0:nspin            
            idx=find(nz_list==kk);
            if isempty(idx)
               pro_mat(kk+1,n)=0;
            else
               pro_mat(kk+1,n)=sum(pro_list(idx));                 
            end            
        end
        
    end

end



function [spin_num_list, probability_mat ] = GetStateInfo(obj, spin_collection,rho_vec)
%GETSTATEINFO Summary of this function goes here
%   Detailed explanation goes here
    nspin=spin_collection.getLength;
    spin_num_list=1:nspin;
    ts_superoperator= model.phy.QuantumOperator.SpinOperator.TransformSuperOperator(spin_collection);
    ts_mat=ts_superoperator.getMatrix;
    rho_vec_IST=ts_mat*rho_vec;
%     rho_mat=;
%     nvec=size(rho_mat,2);
%     
%     rho_vec_IST;
%     nz_pos=find(rho_vec_IST);
    probability_mat=1:nspin;
    obj.obj.StoreKeyVariables(spin_num_list,probability_mat);
end


function idx_list = locate_sub_basis( obj, i )
%LOCATE_SUB_BASIS Summary of this function goes here
%   Detailed explanation goes here
full_ba = obj.full_basis;
sub_ba = obj.subspace.full_basis(i,:);
% [~, indx]=ismember(full_ba(:,obj.sub_idx),sub_ba, 'rows');
% idx_list=find(indx==1)';
sub_ba = kron(sub_ba,ones(obj.dim,1));
idx_list=(find(all(full_ba(:,obj.sub_idx)==sub_ba,2)))';
end


function basis_list = get_full_basis( obj, is_bin )
%GET_FULL_BASIS Summary of this function goes here
%  Detailed explanation goes here
dim=obj.dim;
nbody=obj.nbody;
if is_bin
    basis_list=dec2bin((0:dim-1)',nbody)-48;
else
    basis_list=zeros(obj.dim, obj.nbody);
    for i=1:obj.dim
        basis_list(i,:) = obj.idx2basis(i);
    end
end

end


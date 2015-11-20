function res = sparse( obj )
%SPARSE Summary of this function goes here
%   Detailed explanation goes here
    [m,n]=obj.size;
    res=sparse(m,n);
    for ii=1:obj.nProd
        prod_i=obj.kron_prod_cell{ii};
        res=res+prod_i.sparse;
    end

end


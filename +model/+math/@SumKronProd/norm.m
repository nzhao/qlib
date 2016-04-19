function val = norm( obj, varargin )
%NORM Summary of this function goes here
%   Detailed explanation goes here
    for ii=1:obj.nProd
        prod_i=obj.kron_prod_cell{ii};
        if nargin>1
            norm_list=norm(prod_i, varargin{1});
        else
            norm_list=norm(prod_i);
        end
    end
    val=sum(norm_list); 
end


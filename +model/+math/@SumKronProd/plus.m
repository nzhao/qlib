function skp = plus( obj, kp_obj )
%PLUS Summary of this function goes here
%   Detailed explanation goes here
    if isa(kp_obj, 'KronProd')
        new_cell=[obj.kron_prod_cell, {kp_obj}];
    elseif isa(kp_obj, 'model.math.SumKronProd')
        new_cell=[obj.kron_prod_cell, kp_obj.kron_prod_cell];
    else
        error('PLUS of class %s is not supoorted', class(kp_obj));
    end
    skp=model.math.SumKronProd(new_cell);
end


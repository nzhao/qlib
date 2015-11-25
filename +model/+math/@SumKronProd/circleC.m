function new_skp = circleC( obj )
%CIRCLEC Summary of this function goes here
%   Detailed explanation goes here

    prod_cell=cell(1, obj.nProd);
    for ii=1:obj.nProd
        prod_cell{ii}=obj.kron_prod_cell{ii}.circleC;
    end
    new_skp=model.math.SumKronProd(prod_cell);
end


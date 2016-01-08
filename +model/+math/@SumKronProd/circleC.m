function new_skp = circleC( obj )
%CIRCLEC Summary of this function goes here
%   Detailed explanation goes here

    prod_cell=cell(1, 2*obj.nProd);
    for ii=1:obj.nProd
        sum_kron_prod=obj.kron_prod_cell{ii}.circleC;
        prod_cell{2*ii-1}=sum_kron_prod.kron_prod_cell{1};
        prod_cell{2*ii}=sum_kron_prod.kron_prod_cell{2};
        
    end
    new_skp=model.math.SumKronProd(prod_cell);
end


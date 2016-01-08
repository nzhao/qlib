function v_out = mtimes( obj, v_in )
%MTIMES Summary of this function goes here
%   Detailed explanation goes here
    try all(size(v_in)==obj.domainsizes);
        v_in_size_matchQ=1;
    catch
        v_in_size_matchQ=0;
    end
    
    if obj.domainsizes_matchQ && obj.rangesizes_matchQ && v_in_size_matchQ
        v_out=zeros(obj.rangesizes);
    else
        v_out=zeros(obj.size, 1);
        v_in=v_in(:);
    end
    
    for ii=1:obj.nProd
        prod_i=obj.kron_prod_cell{ii};
        v_out=v_out+prod_i*v_in;
    end
end


function basis = idx2basis( obj, idx )
%IDX2BASIS Summary of this function goes here
%   Detailed explanation goes here
basenum=obj.basenum;
nbody=obj.nbody;
basis=zeros(1, nbody);

idx1=idx-1;
for i=1:nbody
    r=fix(idx1/basenum(i));
    basis(i)=r;
    idx1=idx1-r*basenum(i);
end

end


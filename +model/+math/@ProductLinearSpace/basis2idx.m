function idx = basis2idx( obj, basis )
%BASIS2IDX Summary of this function goes here
%   Detailed explanation goes here
basenum=obj.basenum;
idx = sum(basis.*basenum);

end


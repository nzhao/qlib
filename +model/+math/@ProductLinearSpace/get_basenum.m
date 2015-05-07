function basenumber = get_basenum( obj )
%GET_BASENUM Summary of this function goes here
%   Detailed explanation goes here

%basenumber=zeros(1, obj.nbody);
% for i=1:obj.nbody
%     basenumber(i)=prod(obj.dim_list(i+1:end));
% end
%basenumber1=cumprod([obj.dim_list, 1], 'reverse');
%basenumber=basenumber1(2:end);
dimlist1=[obj.dim_list,1];
r_prod=cumprod(dimlist1(end:-1:1));
basenumber1=r_prod(end:-1:1);
basenumber=basenumber1(2:end);
end



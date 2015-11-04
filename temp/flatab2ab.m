function [ n,m,a,b ] = flatab2ab( n,m,a,b )
%FLATAB2AB Summary of this function goes here
%   Flatab2ab transform ab to original ab form.
ai=find(a);
n=n(ai);
m=m(ai);
a=a(ai);
b=b(ai);
end


function [a0,b0,n,m]=abLin2Nie(a1,b1,n1,m1)
%
%abLin2Nie function transform the [a0,b0] in Lin's note to Nieminen's.
N=length(n1);
a0=zeros(N,1);b0=zeros(N,1);
pre=sqrt(4*pi);
for ii=1:N
    a0(ii)=(1i)^(n1(ii)-1)*pre*b1(ii);
    b0(ii)=(1i)^(n1(ii)-1)*pre*a1(ii);
end
n=n1;m=m1;
end
    
    
    
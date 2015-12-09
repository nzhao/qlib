function [a0,b0,n,m]=abNie2Lin(a1,b1,n1,m1)
%
%abNie2Lin function transform the [a0,b0] in Nieminen's to Lin's note.
N=length(a1);
a0=zeros(N,1);b0=zeros(N,1);
pre=1.0/sqrt(4*pi);
for ii=1:N
    a0(ii)=(1i)^(1-n1(ii))*pre*b1(ii);
    b0(ii)=(1i)^(1-n1(ii))*pre*a1(ii);
end
n=n1;m=m1;
end
    
    
    
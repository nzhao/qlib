function [Tab, Tcd, Tfg, a,b] = tmatrix_MLSphere(Nmax,k_medium,k_particle,radius)
%tmatrix_MLSphere calculates the T matrix of MultiLayerSphere
%
%we used the formualtion of Lin's note on Page 18: multiply-coated sphere.
import ott13.*
n=(1:Nmax).';
m = k_particle./k_medium;

M=Nmax; N=length(m);
A=zeros(M,N);B=zeros(M,N);
At=zeros(M,N);Bt=zeros(M,N);
d=zeros(M,N);c=zeros(M,N);
g=zeros(M,N);f=zeros(M,N);

% r0 = k_medium(1) * radius(1);
% r1 = k_particle(1) * radius(1);
r0 = k_medium.* radius;%xj=k*r
r1 = k_particle.* radius;%mj*xj=mj*k*r=k_particle*r
r2 = m(2:end)./m(1:end-1).*r1(1:end-1);r2=[r2,1];%The last element 1 only occupies vacancy.

indexing=combined_index(1:Nmax^2+2*Nmax)';
%Since M~100,N~10 is not large, we store all of them.
j0=zeros(M,N);j1=zeros(M,N);j2=zeros(M,N);
y0=zeros(M,N);y1=zeros(M,N);y2=zeros(M,N);
h0=zeros(M,N);h1=zeros(M,N);h2=zeros(M,N);
j0d=zeros(M,N);j1d=zeros(M,N);j2d=zeros(M,N);
y0d=zeros(M,N);y1d=zeros(M,N);y2d=zeros(M,N);
h0d=zeros(M,N);h1d=zeros(M,N);h2d=zeros(M,N);
for jj=1:N 
j0(:,jj) = sbesselj(n,r0(jj));
j1(:,jj) = sbesselj(n,r1(jj));
j2(:,jj) = sbesselj(n,r2(jj));
y0(:,jj) = sbessely(n,r0(jj));
y1(:,jj) = sbessely(n,r1(jj));
y2(:,jj) = sbessely(n,r2(jj));
h0(:,jj) = sbesselh1(n,r0(jj));
h1(:,jj) = sbesselh1(n,r1(jj));
h2(:,jj) = sbesselh1(n,r2(jj));

j0d(:,jj) = (n+1).*sbesselj(n,r0(jj))./r0(jj) - sbesselj(n+1,r0(jj));
j1d(:,jj) = (n+1).*sbesselj(n,r1(jj))./r1(jj) - sbesselj(n+1,r1(jj));
j2d(:,jj) = (n+1).*sbesselj(n,r2(jj))./r2(jj) - sbesselj(n+1,r2(jj));
y0d(:,jj) = (n+1).*sbessely(n,r0(jj))./r0(jj) - sbessely(n+1,r0(jj));
y1d(:,jj) = (n+1).*sbessely(n,r1(jj))./r1(jj) - sbessely(n+1,r1(jj));
y2d(:,jj) = (n+1).*sbessely(n,r2(jj))./r2(jj) - sbessely(n+1,r2(jj));
h0d(:,jj) = (n+1).*sbesselh1(n,r0(jj))./r0(jj) - sbesselh1(n+1,r0(jj));
h1d(:,jj) = (n+1).*sbesselh1(n,r1(jj))./r1(jj) - sbesselh1(n+1,r1(jj));
h2d(:,jj) = (n+1).*sbesselh1(n,r2(jj))./r2(jj) - sbesselh1(n+1,r2(jj));

D01(:,jj) = j0d./j0; D02(:,jj) = y0d./y0; D03(:,jj) = h0d./h0;
D11(:,jj) = j1d./j1; D12(:,jj) = y1d./y1; D13(:,jj) = h1d./h1;
D21(:,jj) = j2d./j2; D22(:,jj) = y2d./y2; D23(:,jj) = h2d./h2;
end 
for jj=1:N
R(:,jj)    = j2./h2.*h1./j1@@@need jj

%jj=1 is initial condition
A(:,1)=0;B(:,1)=0;
At(:,1)=D11(:,1);Bt(:,1)=D11(:,1);
for jj=2:N
A(:,jj)=R(:,jj).*(m(jj)*At(:,jj-1)-m(jj-1)*D21(:,jj-1))./(m(jj)*At(:,jj-1)-m(jj-1)*D23(:,jj-1));
B(:,jj)=R(:,jj).*(m(jj-1)*Bt(:,jj-1)-m(jj)*D21(:,jj-1))./(m(jj-1)*Bt(:,jj-1)-m(jj)*D23(:,jj-1));
At(:,jj)=(D11(:,jj)- A(:,jj).*D13(:,jj))./(1-A(:,jj));
Bt(:,jj)=(D11(:,jj)- B(:,jj).*D13(:,jj))./(1-B(:,jj));
end

for jj=N-1:-1:1
   dnj(:,jj)=Tnj(:,jj)./(1-A(:,jj)).*(1-A(:,jj+1)./R(:,jj+1)).*dnj(:,jj+1);
end




end
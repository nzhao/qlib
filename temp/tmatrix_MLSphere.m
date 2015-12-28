function [Tab, Tcd, Tfg] = tmatrix_MLSphere(Nmax,k_medium,k_particle,radius)
%tmatrix_MLSphere calculates the T matrix of MultiLayerSphere
%
%we used Lin's note on Page 18: multiply-coated sphere.
import ott13.*
n=1:Nmax;%row vector will omit the .' in Line28-46. However, here we use the 
         % convention of OTT because the ott13.sbesselj has a n'.
m = k_particle./k_medium;

M=Nmax; N=length(m); MM=2*(Nmax^2+2*Nmax);
A=zeros(M,N);B=zeros(M,N);
At=zeros(M,N);Bt=zeros(M,N);
d=zeros(M,N);c=zeros(M,N);
g=zeros(M,N);f=zeros(M,N);
indexing=combined_index(1:Nmax^2+2*Nmax)';

%% get A,B
r0 = k_medium.* radius;%xj=k*r
r1 = k_particle.* radius;%mj*xj=mj*k*r=k_particle*r
r2 = m(2:end)./m(1:end-1).*r1(1:end-1);r2=[r2,r0(end)];
%Since M~100,N~10 is not large, we store all of them.
j0=zeros(M,N);j1=zeros(M,N);j2=zeros(M,N);
% y0=zeros(M,N);y1=zeros(M,N);y2=zeros(M,N);
h0=zeros(M,N);h1=zeros(M,N);h2=zeros(M,N);
j0d=zeros(M,N);j1d=zeros(M,N);j2d=zeros(M,N);
% y0d=zeros(M,N);y1d=zeros(M,N);y2d=zeros(M,N);
h0d=zeros(M,N);h1d=zeros(M,N);h2d=zeros(M,N);
for jj=1:N
    j0(:,jj) = (sbesselj(n,r0(jj))).';
    j1(:,jj) = (sbesselj(n,r1(jj))).';
    j2(:,jj) = (sbesselj(n,r2(jj))).';
%     y0(:,jj) = (sbessely(n,r0(jj))).';
%     y1(:,jj) = (sbessely(n,r1(jj))).';
%     y2(:,jj) = (sbessely(n,r2(jj))).';
    h0(:,jj) = (sbesselh1(n,r0(jj))).';
    h1(:,jj) = (sbesselh1(n,r1(jj))).';
    h2(:,jj) = (sbesselh1(n,r2(jj))).';
    
    j0d(:,jj) = ((n+1).*sbesselj(n,r0(jj))./r0(jj) - sbesselj(n+1,r0(jj))).';
    j1d(:,jj) = ((n+1).*sbesselj(n,r1(jj))./r1(jj) - sbesselj(n+1,r1(jj))).';
    j2d(:,jj) = ((n+1).*sbesselj(n,r2(jj))./r2(jj) - sbesselj(n+1,r2(jj))).';
%     y0d(:,jj) = ((n+1).*sbessely(n,r0(jj))./r0(jj) - sbessely(n+1,r0(jj))).';
%     y1d(:,jj) = ((n+1).*sbessely(n,r1(jj))./r1(jj) - sbessely(n+1,r1(jj))).';
%     y2d(:,jj) = ((n+1).*sbessely(n,r2(jj))./r2(jj) - sbessely(n+1,r2(jj))).';
    h0d(:,jj) = ((n+1).*sbesselh1(n,r0(jj))./r0(jj) - sbesselh1(n+1,r0(jj))).';
    h1d(:,jj) = ((n+1).*sbesselh1(n,r1(jj))./r1(jj) - sbesselh1(n+1,r1(jj))).';
    h2d(:,jj) = ((n+1).*sbesselh1(n,r2(jj))./r2(jj) - sbesselh1(n+1,r2(jj))).';
    
    % D01(:,jj) = j0d./j0; D02(:,jj) = y0d./y0; D03(:,jj) = h0d./h0;
    % D11(:,jj) = j1d./j1; D12(:,jj) = y1d./y1; D13(:,jj) = h1d./h1;
    % D21(:,jj) = j2d./j2; D22(:,jj) = y2d./y2; D23(:,jj) = h2d./h2;
end
D01 = j0d./j0;  D03 = h0d./h0; %D02 = y0d./y0;
D11 = j1d./j1;  D13 = h1d./h1; %D12 = y1d./y1; 
D21 = j2d./j2;  D23 = h2d./h2; %D22 = y2d./y2;

R=zeros(M,N);% The R needs at least jj and jj-1, so we shoule at least store all of them before.
for jj=2:N
    R(:,jj) = j2(:,jj-1)./h2(:,jj-1).*h1(:,jj)./j1(:,jj);
end

%jj=1 is initial condition
A(:,1)=0;B(:,1)=0;
At(:,1)=D11(:,1);Bt(:,1)=D11(:,1);
for jj=2:N
    A(:,jj)=R(:,jj).*(m(jj)*At(:,jj-1)-m(jj-1)*D21(:,jj-1))./(m(jj)*At(:,jj-1)-m(jj-1)*D23(:,jj-1));
    B(:,jj)=R(:,jj).*(m(jj-1)*Bt(:,jj-1)-m(jj)*D21(:,jj-1))./(m(jj-1)*Bt(:,jj-1)-m(jj)*D23(:,jj-1));
    At(:,jj)=(D11(:,jj)- A(:,jj).*D13(:,jj))./(1-A(:,jj));
    Bt(:,jj)=(D11(:,jj)- B(:,jj).*D13(:,jj))./(1-B(:,jj));
end
%% get a,b
a = j0(:,N)./h0(:,N).*(At(:,N)-m(N)*D01(:,N))./(At(:,N)-m(N)*D03(:,N));
b = j0(:,N)./h0(:,N).*(m(N)*Bt(:,N)-D01(:,N))./(m(N)*Bt(:,N)-D03(:,N));
% Tab=sparse(1:MM,1:MM,[a(indexing);b(indexing)]);
Tab=sparse(1:MM,1:MM,[-b(indexing);-a(indexing)]);

%% get c,d,f,g
if nargout>1 %if we don't care about inner field, we can pass the below part.
    S=zeros(M,N);T=zeros(M,N);
    for jj=N:-1:1
        S(:,jj) = r2(jj)/r1(jj)*j2(:,jj)./h1(:,jj);
        T(:,jj) = r2(jj)/r1(jj)*j2(:,jj)./j1(:,jj);
    end
    
    %jj=N is inital condition
    d(:,N)=                T(:,N)./(1-A(:,N)).*(1-a.*h0(:,N)./j0(:,N));
    g(:,N)=       -S(:,N).*A(:,N)./(1-A(:,N)).*(1-a.*h0(:,N)./j0(:,N));
    c(:,N)=  m(N)        .*T(:,N)./(1-B(:,N)).*(1-b.*h0(:,N)./j0(:,N));
    f(:,N)= -m(N).*S(:,N).*B(:,N)./(1-B(:,N)).*(1-b.*h0(:,N)./j0(:,N));
    for jj=N-1:-1:1
        d(:,jj)=           T(:,jj)./(1-A(:,jj)).*(1-A(:,jj+1)./R(:,jj+1)).*d(:,jj+1);
        g(:,jj)= -S(:,jj).*A(:,jj)./(1-A(:,jj)).*(1-A(:,jj+1)./R(:,jj+1)).*d(:,jj+1);
        c(:,jj)=  m(jj)./m(jj+1)         .*T(:,jj)./(1-B(:,jj)).*(1-B(:,jj+1)./R(:,jj+1)).*c(:,jj+1);
        f(:,jj)= -m(jj)./m(jj+1).*S(:,jj).*B(:,jj)./(1-B(:,jj)).*(1-B(:,jj+1)./R(:,jj+1)).*c(:,jj+1);
    end
    %convert to diagonal matrix
    Tcd=zeros(MM,MM,N);Tfg=zeros(MM,MM,N);
    for jj=1:N
        cc=c(:,jj);dd=d(:,jj);ff=f(:,jj);gg=g(:,jj);
        Tcd(:,:,jj)=sparse(1:MM,1:MM,[cc(indexing);dd(indexing)]);%Tcd=sparse(Tcd);
        Tfg(:,:,jj)=sparse(1:MM,1:MM,[ff(indexing);gg(indexing)]);%Tfg=sparse(Tfg);
    end
end

% [a,b]
% [c,d,f,g]

end
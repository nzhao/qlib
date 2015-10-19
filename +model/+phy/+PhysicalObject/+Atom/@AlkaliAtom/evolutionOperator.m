function [G,G0,G1,G2,dGdw]=evolutionOperator(Gmc,S1,Dnu,thetaD,phiD,Etheta,Ephi,J,I,S,B)
Dw=2*pi*1e6* Dnu;
hP=6.6262e-27;%Planck?s constant in erg/Hz 
hbar=hP/(2*pi);%in erg s 
gS=2*S+1;gI=2*I+1;gJ=2*J+1;gg=gI*gS;ge=gI*gJ;gt=(gg+ge)^2;
if J==1.5
    te=25.5e-9;%spontaneous P1/2 lifetime in s
elseif J==0.5
    te=28.5e-9;%spontaneous P1/2 lifetime in s
end
Pg=eye(gg);Pe=eye(ge);cPg=Pg(:);rPg=cPg(:)';
Acgg=eye(gg*gg)-cPg*rPg/gg;%uniform-relaxation matrix 
%G0=dark, G1=pumping, G2=collisions; dGdw=dG/dw 
G0=zeros(gt,gt); G1=G0; G2=0;dGdw=G0; 
%index ranges for blocks 
[Eg,~,Ee,~]=eigenValueVector(I,J,B);
Hee=Ee*ones(1,ge)-ones(ge,1)*Ee';
Hge=Eg*ones(1,ge)-ones(gg,1)*Ee';
Heg=Ee*ones(1,gg)-ones(ge,1)*Eg';
Hgg=Eg*ones(1,gg)-ones(gg,1)*Eg';
n1=1:ge^2; n2=ge^2+1:ge^2+ge*gg; n3=ge^2+ge*gg+1:ge^2+2*ge*gg; ... 
n4=ge^2+2*ge*gg+1:(ge+gg)^2; 
tV=electricDipoleInteraction(S1,thetaD,phiD,Etheta,Ephi,J,I,B);
G1(n1,n2)=kron(Pe,tV)*1j/hbar;%upper off diagonal elements 
G1(n1,n3)=-kron(conj(tV),Pe)*1j/hbar; 
G1(n2,n4)=-kron(conj(tV),Pg)*1j/hbar; 
G1(n3,n4)=kron(Pg,tV)*1j/hbar; 
G1=G1-G1';%add antihermitian conjugate 
G2(n4,n4)=Gmc*Acgg; 
dGdw(n2,n2)=1j*eye(ge*gg);%dG/dw 
dGdw(n3,n3)=-dGdw(n2,n2); 
G0(n1,n1)=diag(Hee(:)*1j/hbar+1/te);%diagonal elements 
G0(n2,n2)=diag(Hge(:)*1j/hbar+1/(2*te)); 
G0(n3,n3)=diag(Heg(:)*1j/hbar+1/(2*te)); 
G0(n4,n4)=diag(Hgg(:)*1j/hbar); 
Asge=coupledSpontaneousMatrix(J,I,S,B);
G0(n4,n1)=-Asge/te;%repopulation by stimulated emission 
G=G0+G1+G2+Dw*dGdw;%total damping matrix 

%Code02_01 %constants, atomic properties
%Code03_01 %uncoupled spin matrices
%Code03_02 %energy basis states, unitary matrices
%Code03_06 %zero-field energies
%Code04_01 %projection operators
%Code05_02 %spherical projections in electronic space
%Code05_03 %matrices in energy basis, low field labels
%Code05_04 %spontaneous emission matrices
%Code05_05 %light characteristics, interaction matrix
%Code05_06 %energy difference matrices
Gmc=input('Collision rate Gmc = '); 
Acgg=eye(gg*gg)-cPg*rPg/gg;%uniform-relaxation matrix 
%G0=dark, G1=pumping, G2=collisions; dGdw=dG/dw 
G0=zeros(gt,gt); G1=G0; G2=0;dGdw=G0; 
%index ranges for blocks 
n1=1:ge^2; n2=ge^2+1:ge^2+ge*gg; n3=ge^2+ge*gg+1:ge^2+2*ge*gg; ... 
n4=ge^2+2*ge*gg+1:(ge+gg)^2; 
G1(n1,n2)=kron(Pe,tV)*i/hbar;%upper off diagonal elements 
G1(n1,n3)=-kron(conj(tV),Pe)*i/hbar; 
G1(n2,n4)=-kron(conj(tV),Pg)*i/hbar; 
G1(n3,n4)=kron(Pg,tV)*i/hbar; 
G1=G1-G1';%add antihermitian conjugate 
G2(n4,n4)=Gmc*Acgg; 
dGdw(n2,n2)=i*eye(ge*gg);%dG/dw 
dGdw(n3,n3)=-dGdw(n2,n2); 
G0(n1,n1)=diag(Hee(:)*i/hbar+1/te);%diagonal elements 
G0(n2,n2)=diag(Hge(:)*i/hbar+1/(2*te)); 
G0(n3,n3)=diag(Heg(:)*i/hbar+1/(2*te)); 
G0(n4,n4)=diag(Hgg(:)*i/hbar); 
G0(n4,n1)=-Asge/te;%repopulation by stimulated emission 
G=G0+G1+G2+Dw*dGdw;%total damping matrix 

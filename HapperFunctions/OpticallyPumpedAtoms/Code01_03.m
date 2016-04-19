Gmp=input('Gmp=');%optical pumping rate 
Gmc=input('Gmc=');%collisional relaxation rate 
f=input('f=');%fractional transfer rate 
w=input('w=');%rotation rate about y axis 
PS=[1 0; 0 1];%unit operator for Schroedeinger space 
cPS=PS(:); rPS=cPS';%column, row vectors from PS 
Ap=[0 0 0 -2*f;0 1 0 0;0 0 1 0; 0 0 0 2*f];%pumping operator 
Ac=[1 0 0 -1;0 2 0 0;0 0 2 0;-1 0 0 1]/2;%collision operator 
%Spin operators in Schroedinger space 
Sx=[0 1;1 0]/2; Sy=[0 1;-1 0]/(2*i); Sz=[1 0; 0 -1]/2; 
cSx=Sx(:);cSz=Sz(:); rSx=cSx';rSz=cSz';% column, row vectors from Sj 
SyC=[0 1 1 0;-1 0 0 1;-1 0 0 1;0 -1 -1 0]/(2*i);%spin superoperator 
G=Gmp*Ap+Gmc*Ac+i*w*SyC;%damping superoperator 
nt=100; t=linspace(0,5,nt);%sample times 
rho=zeros(4,nt); 
for k=1:nt 
rho(:,k)=expm(-G*t(k))*cPS/2; 
end 
clf; plot(t,real(rSz*rho),'b-'); hold on; grid on; 
plot(t,real(rSx*rho),'r:'); xlabel('time t'); 
legend('\langle S_z \rangle', '\langle S_x \rangle');
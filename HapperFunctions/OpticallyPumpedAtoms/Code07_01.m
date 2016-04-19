% Code02_01 %constants, atomic properties
% Code03_01 %uncoupled spin matrices
% Code03_02 %energy basis states, unitary matrices
% Code03_06 %zero-field energies
% Code04_01 %projection operators
% Code05_02 %spherical projections in electronic space
% Code05_03 %matrices in energy basis, low field labels
% Code06_01 %high pressure optical pumping

Bx=input('Peak oscillating field in Gauss. Bx = ');
Hp1=-Bx*mug(:,:,1)/2;%Fourier amplitude of H
Hp1C=flat(Hp1)-sharp(Hp1);%Liouville version
Lcp1=fgl==a&mgl==a&fgr==b&mgr==b;%logical var. of |aa><bb|
Lcm1=fgl==b&mgl==b&fgr==a&mgr==a;%logical var. of |bb><aa|
L=Lp|Lcp1|Lcm1;%logical variable for secular elements of rho
nk=Lcp1-Lcm1; NL=diag(nk);%indices and effective spin operator
Mp1=nk*ones(1,gg*gg)-ones(gg*gg,1)*nk'==1;%secular approx. matrices
M0=nk*ones(1,gg*gg)-ones(gg*gg,1)*nk'==0;
Mm1=nk*ones(1,gg*gg)-ones(gg*gg,1)*nk'==-1;
tHmrC=Hp1C.*(Mp1+Mm1);%secular part of mag. res. interaction
tAop=Aop.*M0;%secular part of optical pumping matrix
G0s=i*(HgC(L,L)+tHmrC(L,L))/hbar+Gmp*tAop(L,L);%no tuning
om0=(Eg(1)-Eg(gg))/hbar;%resonance freq.
num=.1e6; nnu=201;%maximum detuning and number of samples
om=2*pi*linspace(-num,num,nnu);%sample detunings
rhosin=zeros(sum(L),nnu);%initialize secular density matrix
for k=1:nnu
    Gs=G0s-i*(om0+om(k))*NL(L,L);%include tuning
    rhosin(:,k)=null(Gs);%evaluate steady state
    rhosin(:,k)=rhosin(:,k)/(Lp(L)'*rhosin(:,k));
end
figure (2);clf
subplot(2,1,1); plot(om/(2*pi*1e3),real(rhosin(Lp(L),:))'); grid on;
xlabel('Microwave detuning in kHz'); ylabel('Sublevel populations');

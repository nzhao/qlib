% Code02_01 %constants, atomic properties
% Code03_01 %uncoupled spin matrices
% Code03_02 %energy basis states, unitary matrices
% Code03_06 %zero-field energies
% Code04_01 %projection operators
% Code05_02 %spherical projections in electronic space
% Code05_03 %matrices in energy basis, low field labels
% Code06_01 %high pressure optical pumping
% Code07_01 %microwave resonance
% Code07_02 %Zeeman resonance
Lcp1=fgl==a&mgl==0&fgr==b&mgr==0;%logical var. of |a0><b0|
Lcm1=fgl==b&mgl==0&fgr==a&mgr==0;%logical var. of |b0><a0|
L=Lp|Lcp1|Lcm1;%logical variable for secular elements of rho
nk=Lcp1-Lcm1; NL=diag(nk);%mult. quant. operator
Mp2=nk*ones(1,gg*gg)-ones(gg*gg,1)*nk'==2;%secular approx. matrices
Mp1=nk*ones(1,gg*gg)-ones(gg*gg,1)*nk'==1;
M0=nk*ones(1,gg*gg)-ones(gg*gg,1)*nk'==0;
Mm1=nk*ones(1,gg*gg)-ones(gg*gg,1)*nk'==-1;
Mm2=nk*ones(1,gg*gg)-ones(gg*gg,1)*nk'==-2;
alpha=input('Light-modulation parameter, alpha = ');
m=1:2; fm=real(besselj(m,i*alpha)./(i.^m.*besselj(0,i*alpha)));%sidebands
x=linspace(-.5,1.5,400);%time in oscillation periods
y=exp(alpha*cos(2*pi*x))/besselj(0,i*alpha);
figure (3);clf; subplot(2,1,2); plot (x,y); grid on
xlabel('Time in oscillation periods');ylabel ('Modulatation factor, f')
tAop=Asd.*(M0+fm(2)*(Mp2+Mm2))-(Aex(:,:,3)-2*i*kappa*SC(:,:,3))/2 ...
    .*(fm(1)*(Mp1+Mm1));%secular optical pumping matrix
G0s=i*HgC(L,L)/hbar+Gmp*tAop(L,L);%Gs no tuning
om0=(Eg(a+1)-Eg(3*a+1))/hbar;%resonance frequency
num=1e3; nnu=101;%maximum detuning and number of samples
om=2*pi*linspace(-num,num,nnu);%sample detunings
rhosin=zeros(sum(L),nnu);%initialize secular density matrix
for k=1:nnu
    Gs=G0s-i*(om0+om(k))*NL(L,L);%include tuning
    rhosin(:,k)=null(Gs);%evaluate steady state
    rhosin(:,k)=rhosin(:,k)/(Lp(L)'*rhosin(:,k));
end
subplot (2,1,1); plot(om/(2*pi*1e3),real(rhosin(Lp(L),:))');grid on;
xlabel('Microwave Detuning in kHz'); ylabel('Sublevel Populations');
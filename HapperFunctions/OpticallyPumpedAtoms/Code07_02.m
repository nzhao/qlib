% Code02_01 %constants, atomic properties
% Code03_01 %uncoupled spin matrices
% Code03_02 %energy basis states, unitary matrices
% Code03_06 %zero-field energies
% Code04_01 %projection operators
% Code05_02 %spherical projections in electronic space
% Code05_03 %matrices in energy basis, low field labels
% Code06_01 %high pressure optical pumping
% Code07_01 %microwave resonance
L=fgl==fgr;%logical var. for Zeeman coherences and populations
nk=2*(fgl-I).*mgl-2.*(fgr-I).*mgr;NL=diag(nk);%"spin"
Mp1=nk*ones(1,gg*gg)-ones(gg*gg,1)*nk'==1;%secular approx. matrices
M0=nk*ones(1,gg*gg)-ones(gg*gg,1)*nk'==0;
Mm1=nk*ones(1,gg*gg)-ones(gg*gg,1)*nk'==-1;
tHmrC=Hp1C.*(Mp1+Mm1);%secular part of mag. res. interaction
G0s=i*(HgC(L,L)+tHmrC(L,L))/hbar+Gmp*tAop(L,L);%no tuning
om0=(Eg(1)-Eg(2*a+1))/(2*a*hbar);%resonance frequency
rhosin=zeros(sum(L),nnu);%initialize secular density matrix
for k=1:nnu
    Gs=G0s-i*(om0+om(k))*NL(L,L);%include tuning
    rhosin(:,k)=null(Gs);%evaluate steady state
    rhosin(:,k)=rhosin(:,k)/(Lp(L)'*rhosin(:,k));
end
subplot(2,1,2); plot(om/(2*pi*1e3),real(rhosin(Lp(L),:))'); grid on
xlabel('Radiofrequency detuning in kHz'); ylabel('Sublevel populations');

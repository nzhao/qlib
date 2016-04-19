%Code02_01 %constants, atomic properties
%Code03_01 %uncoupled spin matrices
%Code03_02 %energy basis states, unitary matrices
%Code03_06 %zero-field energies
%Code04_01 %projection operators
%Code05_02 %spherical projections in electronic space
%Code05_03 %matrices in energy basis, low field labels
Gmp=input('Mean pumping rate, Gmp = ');
kappa=input('Shift parameter, kappa = ');
Kj=input('Fictitious spin, [Kx Ky Kz] = ');
for k=1:3
    sharpS(:,:,k)=sharp(Sj(:,:,k));%sharp electron spin matrices
    flatS(:,:,k)=flat(Sj(:,:,k));%flat electron spin matrices
end
SC=flatS-sharpS;%Liouville-space spin matrices
Asd=matdot(SC,SC)/2;%S-damping matrix
Aex=flatS+sharpS-2*i*matcross(flatS,sharpS);%exchange matrix
%high-pressure optical pumping matrix
Aop=Asd-Kj(1)*Aex(:,:,1)-Kj(2)*Aex(:,:,2)-Kj(3)*Aex(:,:,3) ...
    -2*i*kappa*(Kj(1)*SC(:,:,1)+Kj(2)*SC(:,:,2)+Kj(3)*SC(:,:,3));
HgC=flat(Hg)-sharp(Hg);%Liouville-space Hamiltonian
G=i*HgC/hbar+Gmp*Aop; %static damping operator
Lp=logical(cPg);%logical variable for populations
nt=100;%number of sample points
t=linspace(0,40,nt);%sample times in units of 1/Gmp
rhoc=zeros(gg,nt);%initialize compactified density matrix
for k=1:nt%evaluate transient
    rhoc(:,k)=expm(-t(k)*G(Lp,Lp)/Gmp)*cPg(Lp)/gg;
end
clf; plot(t,rhoc); grid on; hold on
rhocin=null(G(Lp,Lp));rhocin=rhocin/sum(rhocin);%steady state
plot(t,rhocin*ones(1,nt), '-.')
xlabel('Time in units of 1/\Gamma_p^{\{g\}}')
ylabel('Sublevel populations')

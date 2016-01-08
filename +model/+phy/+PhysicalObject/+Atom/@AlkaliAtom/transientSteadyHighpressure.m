
function transientSteadyHighpressure(obj,I,magB,Gmp,kappa,Kj1,Kj2,Kj3)
gg=obj.dimG;
gI=2*I+1;
ele=obj.gSpin;
 sSj(:,:,1)=ele.sx;
    sSj(:,:,2)=ele.sy;
    sSj(:,:,3)=ele.sz; 
    [Ug,~]=eig(obj.gsHamiltonian(magB));
   for k=1:3
        gSj=zeros(gg,gg);
        Sj=zeros(gg,gg);
        gSj(:,:,k)=kron(eye(gI),sSj(:,:,k));
       Sj(:,:,k)=Ug'*gSj(:,:,k)*Ug;
    end
for k=1:3
    sharpS=zeros(gg,gg);
    sharpS(:,:,k)=sharp(Sj(:,:,k));%sharp electron spin matrices
    flatS=zeros(gg,gg);
    flatS(:,:,k)=flat(Sj(:,:,k));%flat electron spin matrices
end
SC=flatS-sharpS;%Liouville-space spin matrices
Asd=matdot(SC,SC)/2;%S-damping matrix
Aex=flatS+sharpS-2*1i*matcross(flatS,sharpS);%exchange matrix
%high-pressure optical pumping matrix
Aop=Asd-Kj(1)*Aex(:,:,1)-Kj(2)*Aex(:,:,2)-Kj(3)*Aex(:,:,3) ...
    -2*1i*kappa*(Kj1*SC(:,:,1)+Kj2*SC(:,:,2)+Kj3*SC(:,:,3));
HgC=flat(Hg)-sharp(Hg);%Liouville-space Hamiltonian
G=1i*HgC/hbar+Gmp*Aop; %static damping operator
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
end

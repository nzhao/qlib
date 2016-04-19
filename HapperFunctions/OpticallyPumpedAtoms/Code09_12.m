Code01_07  %atomic properties
Code09_04  %cycling transition matrices
Code09_05  %compactification
Code09_06  %compactification
Code09_07  %left and right quantum numbers
mue=kron(ones(ge,1),(fe:-1:-fe)');%left spin indices of excited state
nue=kron((fe:-1:-fe)',ones(ge,1));%right spin indices of excited state
lpe=mue==nue;%logical variable for excited-state populations
Apeg=(kron(conj(tV(:,:,1)),tV(:,:,1))+kron(conj(tV(:,:,2)),tV(:,:,2)))...
    *(1/(i*hbar*Gpg))*(1/E0-1/conj(E0));%excitation matrix
Arp=2*real((-Nnw(lpg,lpg)-Nse(lpg,lpg))/E0);
dArp=2*real((-Nnw(lpg,lpg)+Nse(lpg,lpg))/E0);
Aop=2*real((Nnw(lpg,lpg)+Nuu(lpg,lpg)+Ndd(lpg,lpg)+Nse(lpg,lpg))/E0);
[raj aj]=eig(Aop);%eigenvalues and right eigenvectors of sAop
[aj, nr]=sort(diag(real(aj))); raj=raj(:,nr);%sorted right eigenvectors
raj(:,1)=raj(:,1)/sum(raj(:,1));%renormalize non-relaxing eigenvector
laj=inv(raj);%find left eigenvectors
piAop=zeros(gg,gg);%initialize
for k=2:gg%pseudoinverse of sAop
    piAop=piAop+raj(:,k)*laj(k,:)/aj(k);
end
Dop=real(laj(1,:)*(Arp/2+dArp*piAop*dArp)*raj(:,1));
T20=zeros(ge,ge);%initialize multipole moment
for me=fe:-1:-fe
    T20(fe-me+1,fe-me+1)=cg(fe,me,2,0,fe,me)*sqrt(5/ge);
end
rhoe=Apeg(lpe,lpg)*raj(:,1);%excited-state density matrix
Dse=real(sum((eye(ge)-(-1)^(fe-fg)* ...
    (sqrt(6)*ge/5)*sixj(1,1,2,fe,fe,fg)*T20)*rhoe)/6);
disp(['D_{op} = ' num2str(Dop) '; D_{se}= ' num2str(Dse)])

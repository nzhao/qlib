% Code02_01 %constants, atomic properties
% Code03_01 %uncoupled spin matrices
% Code03_02 %energy basis states, unitary matrices
% Code03_06 %zero-field energies
% Code04_01 %projection operators
% Code05_02 %spherical projections in electronic space
% Code05_03 %matrices in energy basis, low field labels
% Code05_04 %spontaneous emission matrices

St=1e4*input('one-way trap flux in mW/cm^2, St = ');%to erg/(s cm^2)
eta=input('helicity, eta = ');
v=input('velocity in cm/s, v = ');
tE=sqrt(4*pi*St/c);%field amplitude in esu/cm^2
tV=-D*Dj(:,:,1)'*tE;%interaction for field along x axis
Dnut=1e6*input('trap detuning in MHz, Dnut = ');
Dw=(Eef(1)-Egf(1))/hbar+2*pi*Dnut;
Hee=Ee*ones(1,ge)-ones(ge,1)*Ee';
Heg=Ee*ones(1,gg)-ones(ge,1)*Eg';
Fee=me*ones(1,ge)-ones(ge,1)*me';
Feg=me*ones(1,gg)-ones(ge,1)*mg';
Eeg=Heg-hbar*(Dw-keg*v*eta*Feg+0.5*i/te);%complex energy differences
tW=tV./Eeg; dHg=-tV'*tW; dHe=tV*tW';
dGmg=(dHg-dHg')*i/hbar; dGme=(dHe-dHe')*i/hbar;
cdGmg=dGmg(:); rdGmg=cdGmg';%row and column vectors
cdGme=dGme(:); rdGme=cdGme';
Gmpg=rdGmg*cPg/gg; Gmpe=rdGme*cPe/ge;
Apgg=(flat(dHg)-sharp(dHg)')/(-i*hbar*Gmpg);
Apee=(flat(dHe)-sharp(dHe)')/(-i*hbar*Gmpe);
Apeg=(kron(conj(tV),tW)-kron(conj(tW),tV))/(i*hbar*Gmpg);
Apge=(kron(tW.',tV')-kron(tV.',tW'))/(i*hbar*Gmpe);
Adp=Apgg;
Arp=(Asge/te)*(diag(i*Hee(:)/hbar+i*eta*keg*v*Fee(:)+1/te))^(-1)*Apeg;
Aop=Adp-Arp; HgC=flat(Hg)-sharp(Hg); FzgC=flat(Fzg)-sharp(Fzg);
G=i*(HgC/hbar+eta*keg*v*FzgC)+Gmpg*Aop;
L=fgl==fgr;%log. var. to neglect hfs coherences
Lp=fgl==fgr&mgl==mgr;%log. var. for populations
cLp=Lp(L);%log. var. for pops. in compactified space
t=10/Gmpg;%10 optical pumping cycles
rhoct=expm(-t*G(L,L))*cPg(L)/gg;
rhocin=null(G(L,L)); rhocin=rhocin/(rPg(L)*rhocin);%steady state
Fmot=i*eta*keg*tW'*(Fze*tV-tV*Fzg)/kB; cFmot=Fmot(:); rFmot=cFmot';
Ft=rFmot(L)*rhoct; Ft=Ft+conj(Ft);%early-time force
Fin=rFmot(L)*rhocin; Fin=Fin+conj(Fin);%steady-state force

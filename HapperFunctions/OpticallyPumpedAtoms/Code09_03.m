% Code02_01 %constants, atomic properties
% Code03_01 %uncoupled spin matrices
% Code03_02 %energy basis states, unitary matrices
% Code03_06 %zero-field energies
% Code04_01 %projection operators
% Code05_02 %spherical projections in electronic space
% Code05_03 %matrices in energy basis, low field labels
% Code05_04 %spontaneous emission matrices
% Code09_01 %optical pumping for MOT light configuration
% Code09_02 %display short-time and steady-state sublevel populations
fr=input('fractional intensity of repump laser, fr = '); 
tV=sqrt(fr)*tV;%attenuate interaction 
Dw=(Eef(2)-Egf(2))/hbar;%repump detuning 
Eeg=Heg-hbar*(Dw-keg*v*eta*Feg+0.5*i/te); 
tW=tV./Eeg; dHg=-tV'*tW; dHe=tV*tW'; 
dGmg=(dHg-dHg')*i/hbar; dGme=(dHe-dHe')*i/hbar; 
dGmg=(dHg-dHg')*i/hbar; dGme=(dHe-dHe')*i/hbar; 
dGmg=(dHg-dHg')*i/hbar; dGme=(dHe-dHe')*i/hbar; 
cdGmg=dGmg(:); rdGmg=cdGmg';%row and column vectors 
Gmpg=rdGmg*cPg/gg; Gmpe=rdGme*cPe/ge; 
Apgg=(flat(dHg)-sharp(dHg)')/(-i*hbar*Gmpg); 
Apee=(flat(dHe)-sharp(dHe)')/(-i*hbar*Gmpe); 
Apeg=(kron(conj(tV),tW)-kron(conj(tW),tV))/(i*hbar*Gmpg); 
Apge=(kron(tW.',tV')-kron(tV.',tW'))/(i*hbar*Gmpe); 
Adp=Apgg; 
Arp=(Asge/te)*(diag(i*Hee(:)/hbar+i*eta*keg*v*Fee(:)+1/te))^(-1)*Apeg; 
Aop=Adp-Arp; G=G+Gmpg*Aop;%add repumping 
rhoct=expm(-t*G(L,L))*cPg(L)/gg; 
rhocin=null(G(L,L)); rhocin=rhocin/(rPg(L)*rhocin);%steady state 
Fmot=Fmot+i*eta*keg*tW'*(Fze*tV-tV*Fzg)/kB; cFmot=Fmot(:); rFmot=cFmot'; 
Ft=rFmot(L)*rhoct; Ft=Ft+conj(Ft);%early-time force 
Fin=rFmot(L)*rhocin; Fin=Fin+conj(Fin);%steady-state force 
% Code09_02 %display short-time and steady-state sublevel populations

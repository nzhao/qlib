% Code01_07  %atomic properties
% Code09_04  %cycling transition matrices
% Code09_05  %compactification
pmq=eta*(p-q);%azimuthal qn of spin coherences 
gmunu=2*fg-abs(pmq)+1;%number of spin coherences in pq tile 
km=maxpmq/2+1-pmq/2; jf=0;%azimuth index, initial spin index 
for k=1:gpq 
ji=jf+1;%initial coherence index of tile k 
jf=jf+gmunu(k);%final coherence index of tile k 
pp(ji:jf)=p(k);%replicate p for spin states 
qq(ji:jf)=q(k);%replicate q for spin states 
l=lpmq(:,km(k));%l.v. for spin states in tile k 
mmu(ji:jf)=mug(l);%mu for coherence in tile k 
nnu(ji:jf)=nug(l);%nu for coherence in tile k 
lmunu(:,k)=l;%save l.v. for cohrence location in tile k 
in{k}=(ji:jf)';%save coherence indices for each tile k 
end 
pp=pp'; qq=qq'; mmu=mmu'; nnu=nnu'; in=in';%rows to columns 
lp=pp==qq & mmu==nnu;%logical variable of populations 
gsm=length(pp);%number of spin-momentum basis states 
for km=1:maxpmq+1 
lm(:,km)=pp==qq+maxpmq+2-2*km;%logical variables for coherences 
end 

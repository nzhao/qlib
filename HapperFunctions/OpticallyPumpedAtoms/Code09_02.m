%  Code02_01 %constants, atomic properties
%  Code03_01 %uncoupled spin matrices
%  Code03_02 %energy basis states, unitary matrices
%  Code03_06 %zero-field energies
%  Code04_01 %projection operators
%  Code05_02 %spherical projections in electronic space
%  Code05_03 %matrices in energy basis, low field labels
%  Code05_04 %spontaneous emission matrices
%  Code09_01 %optical pumping for MOT light configuration
figure(1); clf; mm=-a:1:a; 
ma=mg(1:2*a+1); mb=mg(2*a+2:gg); 
[xa,ja]=sort(ma); [xb,jb]=sort(mb); 
rho=real(rhoct(cLp));%early populations 
rhoa=rho(1:2*a+1);rhob=rho(2*a+2:gg); 
subplot(2,1,1) 
P=[rhoa(ja),[0;rhob(jb);0]]; 
bar(mm,P,0.5) 
ylabel('\rho(t)') 
grid on; hold on; 
title(['F = ' num2str(Ft) ' k_B K/cm'] ) 
rho=real(rhocin(cLp));%steady-state populations 
rhoa=rho(1:2*a+1);rhob=rho(2*a+2:gg); 
subplot(2,1,2) 
P=[rhoa(ja),[0;rhob(jb);0]];bar(mm,P,0.5);grid on; 
ylabel('\rho(\infty)'); xlabel('Azimuthal quantum number, m') 
title(['F = ' num2str(Fin) ' k_B K/cm'] ) 

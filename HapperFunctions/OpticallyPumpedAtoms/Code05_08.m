%Code02_01 %constants, atomic properties
%Code03_01 %uncoupled spin matrices
%Code03_02 %energy basis states, unitary matrices
%Code03_06 %zero-field energies
%Code04_01 %projection operators
%Code05_02 %spherical projections in electronic space
%Code05_03 %matrices in energy basis, low field labels
%Code05_04 %spontaneous emission matrices
%Code05_05 %light characteristics, interaction matrix
%Code05_06 %energy difference matrices
%Code05_07 %Optical Bloch Equations with uniform damping
rt=input('relative pulse length, rt=tm/te = '); 
tm=rt*te; 
nt=101;%number of time samples 
th=linspace(0,tm,nt);%time samples 
rhot=zeros(gt,nt);%initialize density matrix 
rho0=[zeros(ge^2+2*ge*gg,1);cPg]/gg;%density matrix at t=0 
for k=1:nt 
rhot(:,k)=expm(-G*th(k))*rho0; 
end 
Ne=rNe*rhot;%excited-state probability 
Ng=rNg*rhot;%ground-state probability 
clf; plot(th/te,real(Ng),'b-'); hold on; 
plot(th/te,real(Ne),'r-.');grid on; 
xlabel('Time, \Gamma^{\{ge\}}_{\rm s}t'); 
ylabel('Populations'); legend('Ng','Ne')
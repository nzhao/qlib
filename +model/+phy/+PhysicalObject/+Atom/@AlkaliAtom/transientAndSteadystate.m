function transientAndSteadystate(obj,rt,Dnu,J,magB)
if J==1.5
    te=obj.parameters.te1;%spontaneous P1/2 lifetime in s
    ge=obj.dimE2;
elseif J==0.5
    te=obj.parameters.te2;%spontaneous P1/2 lifetime in s
    ge=obj.dimE1;
else
    disp('Error J')
end
gg=obj.dimG;
gt=(gg+ge)^2;
Pg=eye(gg);Pe=eye(ge);cPe=Pe(:);cPg=Pg(:);
cNe=[cPe;zeros(gt-ge*ge,1)];rNe=cNe';
cNg=[zeros(gt-gg*gg,1);cPg];rNg=cNg';
rP=rNe+rNg; 
tm=rt*te; 
nt=101;%number of time samples 
th=linspace(0,tm,nt);%time samples 
rhot=zeros(gt,nt);%initialize density matrix 
rho0=[zeros(ge^2+2*ge*gg,1);cPg]/gg;%density matrix at t=0
[G,~,~,~,~]=obj.evolutionOperator(Dnu,J,magB);
for k=1:nt 
rhot(:,k)=expm(-G*th(k))*rho0; 
end 
Ne=rNe*rhot;%excited-state probability 
Ng=rNg*rhot;%ground-state probability 
clf; plot(th/te,real(Ng),'b-'); hold on; 
plot(th/te,real(Ne),'r-.');grid on; 
xlabel('Time, \Gamma^{\{ge\}}_{\rm s}t'); 
ylabel('Populations'); legend('Ng','Ne')

rhoinf=null(G);rhoinf=rhoinf/(rP*rhoinf); 
Nginf=rNg*rhoinf; Neinf=rNe*rhoinf; 
plot(th/te,real(Nginf)*ones(1,nt),'b-') 
plot(th/te,real(Neinf)*ones(1,nt),'r-.') 
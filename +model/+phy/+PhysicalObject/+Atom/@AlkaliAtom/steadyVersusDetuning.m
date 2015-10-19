function steadyVersusDetuning(Gmc,S1,Dnu,thetaD,phiD,Etheta,Ephi,J,I,S,B)
Dw=2*pi*1e6*Dnu;
if J==1.5
    te=25.5e-9;%spontaneous P1/2 lifetime in s
elseif J==0.5
    te=28.5e-9;%spontaneous P1/2 lifetime in s
end
gS=2*S+1;gI=2*I+1;gJ=2*J+1;gg=gI*gS;ge=gI*gJ;gt=(gg+ge)^2;
nw=21;dw=linspace(Dw-3/te,Dw+3/te,nw); rhow= zeros(gt,nw);
[~,G0,G1,G2,dGdw]=evolutionOperator(Gmc,S1,Dnu,thetaD,phiD,Etheta,Ephi,J,I,S,B);
Pg=eye(gg);Pe=eye(ge);cPe=Pe(:);cPg=Pg(:);
cNe=[cPe;zeros(gt-ge*ge,1)];rNe=cNe';LrNe=logical(rNe);
cNg=[zeros(gt-gg*gg,1);cPg];rNg=cNg';LrNg=logical(rNg);
rP=rNe+rNg;
for k=1:nw
    G=G0+G1+G2+dw(k)*dGdw;
    rhow(:,k)=null(G);rhow(:,k)=rhow(:,k)/(rP*rhow(:,k));
end
figure(2); clf;
subplot(2,1,1)
plot(dw/(2*pi*1e6),real(rNg*rhow),'b-');hold on;%statepopulations
plot(dw/(2*pi*1e6),real(rNe*rhow),'r-.');grid on;
ylabel('StatePopulations');
legend('Ng','Ne')
subplot(2,1,2);%sublevel populations
plot(dw/(2*pi*1e6),real(real(rhow(LrNg,:))),'b-');hold on;
plot(dw/(2*pi*1e6),real(real(rhow(LrNe,:))),'r-.');grid on;
xlabel('Detuning,\Delta\nu inMHz');
ylabel('SublevelPopulations');

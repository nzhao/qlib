function tV=electricDipoleInteraction(obj,Sl,thetaD,phiD,Etheta,Ephi,J,magB)
S=obj.parameters.spin_S;
I=obj.parameters.spin_I;
c=parameters.c;%speed of light in m/s 
hbar=parameters.hbar;%in J s 
re=parameters.re;%classical electron radius in m 
gJ=2*J+1;gS=2*S+1;gI=2*I+1;ge=gJ*gI;gg=gS*gI;
if J==1.5
    lamJ=parameters.lamJ1;%D2 wavelength in m
    te=parameters.te1;%spontaneous P1/2 lifetime in s
elseif J==0.5
    lamJ=parameters.lamJ2;%D1 wavelength in m
    te=parameters.te2;%spontaneous P1/2 lifetime in s
end
keg=2*pi/lamJ; weg=c*keg;%nominal spatial and temporal frequencies
feg=c*gJ/(4*weg^2*re*te);%oscillator strength
D=sqrt(gS*hbar*re*c^2*feg/(2*weg));% dipole moment in esu cm
theta=thetaD*pi/180; phi=phiD*pi/180; %angles in radians
Ej(1)=Etheta*cos(theta)*cos(phi)-Ephi*sin(phi);
Ej(2)=Etheta*cos(theta)*sin(phi)+Ephi*cos(phi);
Ej(3)=-Etheta*sin(theta);%Cartesian projections
tEj=sqrt(2*pi*Sl/c)*Ej/norm(Ej);%field in esu/cm^2
tV=zeros(ge,gg);
Ds=obj.happerMatrixCoupled(J,magB);
for k=1:3 %sum over three Cartesian axes
    tV=tV-D*Ds(:,:,k)'*tEj(k);
end
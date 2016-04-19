Code01_07  %fundamental constants
I=input('I = '); S=input('S = '); J=input('J = ');
%statistical weights
gI=2*I+1; gS=2*S+1; gJ=2*J+1;gg=gI*gS; ge=gI*gJ;
a=I+.5; b=I-.5;%ground-state ang. mom. quant. numbs.
MW=86.9;%grams/mole
LgS=2.00231;% Lande g-value of S1/2 state
LgJ=gJ/3;%approximate Lande g-value of PJ state
muI=2.751*muN;%nuclear moment in erg/G
Ag=hP*3417.35e6;%S1/2 dipole coupling coefficient in erg
if J==1.5
    lamJ=7800e-8;%D2 wavelength in cm
    Ae=hP*84.852e6;%P3/2 dipole coefficient in erg
    Be=hP*12.611e6;%P3/2 quadrupole coupling coefficient in erg
    te=25.5e-9;%spontaneous P1/2 lifetime in s
elseif J==0.5
    lamJ=7947e-8;%D1 wavelength in cm
    Ae=hP*409e6;%P1/2 dipole coupling coefficient in erg
    te=28.5e-9;%spontaneous P1/2 lifetime in s
end
keg=2*pi/lamJ; weg=c*keg;%nominal spatial and temporal frequencies
feg=c*gJ/(4*weg^2*re*te);%oscillator strength
D=sqrt(gS*hbar*re*c^2*feg/(2*weg));% dipole moment in esu cm

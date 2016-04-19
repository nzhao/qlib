%Code02_01 %constants, atomic properties
%Code03_01 %uncoupled spin matrices
%Code03_02 %energy basis states, unitary matrices
%Code03_06 %zero-field energies
%Code04_01 %projection operators
%Code05_02 %spherical projections in electronic space
%Code05_03 %matrices in energy basis, low field labels
%Code05_04 %spontaneous emission matrices
Sl=1e4*input('flux in mW/cm^2, Sl = ');%convert to erg/(s cm^2)
Dw=2*pi*1e6*input('Detuning in MHz, Dnu = ');
%colatitude and azimuthal angles of beam direction in degrees
thetaD = input('thetaD = ');%beam colatitude angle in degrees
phiD = input('phiD = ');%beam azimuthal angle in degrees
theta=thetaD*pi/180; phi=phiD*pi/180; %angles in radians
Etheta = input('Etheta = ');%relative field along theta
Ephi= input('Ephi = ');%relative field along phi
Ej(1)=Etheta*cos(theta)*cos(phi)-Ephi*sin(phi);
Ej(2)=Etheta*cos(theta)*sin(phi)+Ephi*cos(phi);
Ej(3)=-Etheta*sin(theta);%Cartesian projections
tEj=sqrt(2*pi*Sl/c)*Ej/norm(Ej);%field in esu/cm^2
tV=zeros(ge,gg);
for j=1:3 %sum over three Cartesian axes
    tV=tV-D*Dj(:,:,j)'*tEj(j);
end
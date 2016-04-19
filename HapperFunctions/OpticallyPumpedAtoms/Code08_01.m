% Code02_01 %constants, atomic properties
% Code03_01 %uncoupled spin matrices
% Code03_02 %energy basis states, unitary matrices
% Code03_06 %zero-field energies
% Code04_01 %projection operators
% Code05_02 %spherical projections in electronic space
% Code05_03 %matrices in energy basis, low field labels
% Code05_04 %spontaneous emission matrices
% Code05_05 %light characteristics, interaction matrix
% Code05_06 %energy difference matrices
TK=input('Kelvin temperature, TK = ');
sigv=(2*pi/lamJ)*sqrt(kB*TK*NA/MW);%Doppler variance
Dnu1= min(min(Heg/hP))-sigv/2; Dnu2= max(max(Heg/hP))+sigv/2;
ns=2000;%number of sample frequencies
Dnu=linspace(Dnu1,Dnu2,ns); %sample frequencies
sigT=zeros(1,ns); sig0=zeros(1,ns);
for k=1:ns
    %Doppler broadened cross section
    z=-(Heg-hP*Dnu(k)-i*hbar/(2*te))/(hbar*sigv*sqrt(2));
    tWT=tV.*w(z)*i*sqrt(pi/2)/(hbar*sigv);
    dHgT=-tV'*tWT;
    sigT(k)=-(2*weg/Sl)*imag(trace(dHgT)/gg);
    %cross section for atoms at rest
    tW0=tV./(Heg-hP*Dnu(k)-i*hbar/(2*te));
    dHg0=-tV'*tW0;
    sig0(k)=-(2*weg/Sl)*imag(trace(dHg0)/gg);
end
figure (1); clf
subplot(2,1,1); plot(Dnu,sigT); grid on;
ylabel('\sigma in cm^2')
subplot(2,1,2); plot(Dnu,sig0); grid on;
ylabel('\sigma in cm^2')
xlabel('Detuning in GHz')
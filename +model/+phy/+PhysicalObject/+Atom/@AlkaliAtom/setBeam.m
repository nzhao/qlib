function setBeam( obj, Dline, kVec, eVec, Sl)
%SETBEAM Summary of this function goes here
%   Detailed explanation goes here
    gS=obj.gSpin.dim;
    switch Dline
        case 'D1'
            gJ=obj.e2Spin.dim;
            lamJ=obj.parameters.lamJ2;  %D1 wavelength in m
            te=obj.parameters.te2;      %spontaneous P1/2 lifetime in s
        case 'D2'
            gJ=obj.e1Spin.dim;
            lamJ=obj.parameters.lamJ1;  %D2 wavelength in m
            te=obj.parameters.te1;      %spontaneous P1/2 lifetime in s
        otherwise
            disp('error')
    end

    keg=2*pi/lamJ; weg=c_velocity*keg;%nominal spatial and temporal frequencies
    feg=c_velocity*gJ/(4*weg^2*r_e*te);%oscillator strength
    D=sqrt(gS*hbar*r_e*c_velocity^2*feg/(2*weg));% dipole moment in esu cm

    theta=kVec(1)*pi/180; phi=kVec(2)*pi/180; %angles in radians
    Ej(1)= eVec * [cos(theta)*cos(phi), -sin(phi)]';
    Ej(2)= eVec * [cos(theta)*sin(phi),  cos(phi)]';
    Ej(3)= eVec * [-sin(theta), 0.0]';%Cartesian projections
    
    tEj=sqrt(2*pi*Sl/c_velocity)*Ej/norm(Ej);%field in esu/cm^2

    obj.beam.kVec=kVec;
    obj.beam.Ej=Ej;
    obj.beam.tEj=tEj;
    obj.beam.Omega=D*tEj; %optical dipole interaction strength, in ... uint
end


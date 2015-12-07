function [paraxial_beam, focal_beam] = getIncBeam( obj )
%GETINCBEAM Summary of this function goes here
%   Detailed explanation goes here
    import model.phy.PhysicalObject.LaserBeam.ParaxialBeam.ParaxialLaguerreGaussianBeam

    center=obj.parameters.IncBeamCenter;
    pl=obj.parameters.IncBeamP_L;
    power=obj.parameters.IncBeamPower;
    pxpy=obj.parameters.IncBeamPxPy;
    waist=obj.parameters.IncBeamWaist;
    wavelength=obj.parameters.IncBeamWaveLength;

    p=pl(1); l=pl(2);      px=pxpy(1); py=pxpy(2);

    paraxial_beam = ParaxialLaguerreGaussianBeam(wavelength, power, waist, center, p, l, px, py, 'vacuum');
    
end


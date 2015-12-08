function focal_beam = makeFocalBeam( obj, lens, incBeam )
%MAKEFOCALBEAM Summary of this function goes here
%   Detailed explanation goes here
    import model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol
    
    power=obj.parameters.IncBeamPower;
    
    focal_beam=LinearCircularPol(lens, incBeam);
    focal_beam.calcAmpFactor(power);

%     Nmax=ott13.ka2nmax(k*scat1.radius);Nmax=Nmax*5;
    Nmax=obj.parameters.CutOffNMax;
    focal_beam.getVSWFcoeff(Nmax);

end


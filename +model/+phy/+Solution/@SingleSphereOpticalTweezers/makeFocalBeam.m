function focal_beam = makeFocalBeam( obj, lens, incBeam )
%MAKEFOCALBEAM Summary of this function goes here
%   Detailed explanation goes here
    import model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol
    
    power=obj.parameters.IncBeamPower;
    
    focal_beam=LinearCircularPol(lens, incBeam);
    focal_beam.calcAmpFactor(power);

%     k=lg1.focBeam.k;
%     n_relative=scat1.scatter_medium.n/len.work_medium.n; %The relative unit is the wavelength in working medium of len.
%     Nmax=ott13.ka2nmax(k*scat1.radius);Nmax=Nmax*5;Nmax=20;
%     lg1.getVSWFcoeff(Nmax);

end


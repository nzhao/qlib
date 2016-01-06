function beam=prepare_beam( obj, n_max )
%PREPARE_BEAM Summary of this function goes here
%   Detailed explanation goes here
    beam=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(obj.lens, obj.incBeam);
    beam.calcAmpFactor(obj.incBeam.power);
    
    if nargin<2
        n_max=ott13.ka2nmax(obj.incBeam.k*obj.sphere.radius);
        n_max=n_max*5;
    end
    obj.Nmax=n_max;
    
    beam.getVSWFcoeff(obj.Nmax);
end


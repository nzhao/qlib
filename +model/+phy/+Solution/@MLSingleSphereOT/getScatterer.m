function scatterer = getScatterer( obj )
%GETSCATTERER Summary of this function goes here
%   Detailed explanation goes here
    import model.phy.PhysicalObject.Scatterer.MLSphereScatter
    
    postition = obj.parameters.SpherePosition;
    radius    = obj.parameters.SphereRadius;
    medium    = obj.parameters.SphereMedium;
    
    scatterer = MLSphereScatter(postition,radius,medium);
end


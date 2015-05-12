classdef AbstractLaserBeam < model.phy.PhysicalObject.PhysicalObject
    %LASERBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=AbstractLaserBeam(name)
            obj.name=name;
        end
        
    end
    
    methods (Abstract)
        wavefunction(obj, x, y, z)
        getVSWFcoeff
    end
end


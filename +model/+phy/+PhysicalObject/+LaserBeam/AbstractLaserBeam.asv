classdef AbstractLaserBeam < model.phy.PhysicalObject.PhysicalObject
    %LASERBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
    end
    
    
    methods
        function obj=AbstractLaserBeam(name)
            obj.name=name;
        end
        
    end
    
    
    methods (Abstract)
        wavefunction(obj, x, y, z)
        getVSWFcoeff(obj)
    end
end


classdef AbstractLaserBeam < model.phy.PhysicalObject.PhysicalObject
    %LASERBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        wavelength
        intensity
        k
        
        aNNZ
        bNNZ
    end
    
    
    methods
        function obj=AbstractLaserBeam(name, wavelength, intensity)
            obj.name=name;
            obj.wavelength=wavelength;
            obj.intensity=intensity;
            obj.k=2.0*pi/wavelength;
        end
                
    end
    
    
    methods (Abstract)
        wavefunction(obj, x, y, z)
        getVSWFcoeff(obj)
    end
end


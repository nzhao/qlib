classdef AbstractLaserBeam < model.phy.PhysicalObject.PhysicalObject
    %LASERBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        medium
        wavelength
        
        cross_area
        intensity
        power
        k
        
        aNNZ
        bNNZ
    end
    
    
    methods
        function obj=AbstractLaserBeam(name, wavelength, power, cross_area, medium_name)
            if nargin < 4
                medium_name = 'air';
            end
            
            obj.name=name;
            obj.medium=model.phy.data.MediumData.get_parameters(medium_name);
            obj.wavelength=wavelength; %wavelength in medium
            obj.k=2.0*pi/wavelength;   %wave number in medium
            obj.power=power;   %incident power in Walt
            obj.cross_area=cross_area; % cross section area in m^2
            obj.intensity=power/cross_area; % beam intensity Walt/m2
        end
                
    end
    
    
    methods (Abstract)
        wavefunction(obj, x, y, z)
        getVSWFcoeff(obj)
    end
end


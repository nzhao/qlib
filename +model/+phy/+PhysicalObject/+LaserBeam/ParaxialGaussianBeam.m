classdef ParaxialGaussianBeam < model.phy.PhysicalObject.LaserBeam.GaussianBeam
    %PARAXIALGAUSSIANBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function val=wavefunction(obj, x, y, z)
            k=2.0*pi/obj.wavelength;
            val=exp(-(x*x+y*y)/obj.w0^2 + 1.j*k*z);
        end
        
        
    end
    
end


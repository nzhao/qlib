classdef ParaxialGaussianBeam < model.phy.PhysicalObject.LaserBeam.ParaxialBeam.AbstractGaussianBeam
    %PARAXIALGAUSSIANBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=ParaxialGaussianBeam(wavelength, intensity, waist, center)
            obj@model.phy.PhysicalObject.LaserBeam.ParaxialBeam.AbstractGaussianBeam(wavelength, intensity, waist, center);
        end
        
        function val=wavefunction(obj, x, y, z)            
            k=obj.k;
            x0=obj.rc(1); y0=obj.rc(2); z0=obj.rc(3);
            rho2=(x-x0)*(x-x0)+(y-y0)*(y-y0);
            
            val= obj.w0/obj.w(z) ...
                 * exp( - rho2 / (obj.w0*obj.w0)) ...
                 * exp( 1.j* k*(z-z0) ...
                       -1.j* obj.eta(z) ...
                       +1.j* k*rho2/2/obj.R(z) );
        end
        

    end
    
end


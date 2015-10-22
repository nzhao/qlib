classdef AbstractGaussianBeam < model.phy.PhysicalObject.LaserBeam.AbstractLaserBeam
    %GAUSSIANBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        w0
        zR
        rc
    end
    
    methods
        function obj=AbstractGaussianBeam(wavelength, intensity, waist, center)
            obj@model.phy.PhysicalObject.LaserBeam.AbstractLaserBeam('GaussianBeam', wavelength, intensity);
            obj.w0=waist;
            obj.zR=pi*waist*waist/wavelength;
            obj.rc= center;
        end
        function val=wavefunction(obj, x, y, z)            
            x0=obj.rc(1); y0=obj.rc(2); 
            rho2=(x-x0)*(x-x0)+(y-y0)*(y-y0);
            val= obj.w0/obj.w(z) * exp( - rho2 / (obj.w0*obj.w0));
        end

        function val=w(obj, z)
            z0=obj.rc(3); z2=(z-z0)*(z-z0); 
            val=obj.w0*sqrt(1 + z2/obj.zR/obj.zR);
        end
        
        function val=R(obj, z)
            z0=obj.rc(3); 
            if z==z0
                z=z0+eps;
            end
            z2=(z-z0)*(z-z0); 
            val=(z-z0)*(1 + obj.zR*obj.zR/(z2) );
        end
        
        function val=eta(obj, z)
            z0=obj.rc(3); 
            val=atan((z-z0)/obj.zR);
        end
        
        function [a, b]=getVSWFcoeff(maxN)
            a=zeros(1, maxN);
            b=zeros(1, maxN);
        end

    end
    
end


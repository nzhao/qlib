classdef GaussianBeam < model.phy.PhysicalObject.LaserBeam.AbstractLaserBeam
    %GAUSSIANBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        wavelength
        intensity
        waist
        zR
        center
    end
    
    methods
        function obj=GaussianBeam(wavelength, intensity, w0, zR, x0,y0,z0)
            obj@model.phy.PhysicalObject.LaserBeam.AbstractLaserBeam('GaussianBeam');
            obj.wavelength=wavelength;
            obj.intensity=intensity;
            obj.waist=w0;
            obj.zR=zR;
            obj.center= [x0,y0,z0];
        end
        function val=wavefunction(obj, x, y, z)
            k=2.0*pi/obj.wavelength;
            val=exp(-((x-x0)*(x-x0)+(y-y0)*(y-y0))/obj.w0^2 + 1.j*k*(z-z0));
        end
        
        function [a, b]=getVSWFcoeff(maxN)
            a=zeros(1, maxN);
            b=zeros(1, maxN);
        end
    end
    
end


classdef GaussianBeam < model.phy.PhysicalObject.LaserBeam.AbstractLaserBeam
    %GAUSSIANBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        wavelength
        intensity
        waist
        w0
        zR
    end
    
    methods
        function obj=GaussianBeam(wavelength, intensity, w0, zR)
            obj@model.phy.PhysicalObject.LaserBeam.AbstractLaserBeam('GaussianBeam');
            obj.wavelength=wavelength;
            obj.intensity=intensity;
            obj.waist=w0;
            obj.zR=zR;
        end
        function val=wavefunction(obj, x, y, z)
            k=2.0*pi/obj.wavelength;
            val=exp(-(x*x+y*y)/obj.w0^2 + 1.j*k*z);
        end
        
        function [a, b]=getVSWFcoeff(maxN)
            a=zeros(1, maxN);
            b=zeros(1, maxN);
        end
    end
    
end


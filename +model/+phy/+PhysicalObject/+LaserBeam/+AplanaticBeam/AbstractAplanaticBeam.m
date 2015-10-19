classdef AbstractAplanaticBeam <  model.phy.PhysicalObject.LaserBeam.AbstractLaserBeam
    %ABSTRACTAPLANATICBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        p
        l
        f0
        na
        n1
        n2
        aMax
    end
    
    methods
        function obj=AbstractAplanaticBeam(wavelength, intensity, f0, na, n1, n2, p, l)
            obj@model.phy.PhysicalObject.LaserBeam.AbstractLaserBeam('AbstractAplanaticBeam',wavelength, intensity);
            obj.f0=f0;
            obj.na=na;
            obj.n1=n1;
            obj.n2=n2;
            obj.aMax=asin(na/n2);
            obj.p=p;
            obj.l=l;
        end
        
        
        function val=wavefunction(obj, r, theta, phi)%#ok<INUSD>
            val= 0.0;
        end        
        
        function [a, b]=getVSWFcoeff(maxN)
            a=zeros(1, maxN);
            b=zeros(1, maxN);
        end
    end

    
end


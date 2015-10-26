classdef ParaxialLaguerreGaussianBeam < model.phy.PhysicalObject.LaserBeam.ParaxialBeam.AbstractGaussianBeam
    %PARAXIALL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        p
        l
        px
        py
    end
    
    methods
        function obj=ParaxialLaguerreGaussianBeam(wavelength, power, waist, center, p, l, px, py, medium)
            if nargin < 9
                medium='air';
            end
            
            obj@model.phy.PhysicalObject.LaserBeam.ParaxialBeam.AbstractGaussianBeam(wavelength, power, waist, center, medium);
            obj.p=p;
            obj.l=l;
            obj.px=px;
            obj.py=py;
        end
        
        function val=wavefunction(obj, x, y, z)
            k=obj.k;
            x0=obj.rc(1); y0=obj.rc(2); z0=obj.rc(3);
            r2= (x-x0)*(x-x0) + (y-y0)*(y-y0) ;
            r=sqrt(r2);
            
            if x-x0==0
                phi=0;
            elseif x-x0>0
                phi=atan( (y-y0)/(x-x0) );
            else
                phi=pi+atan( (y-y0)/(x-x0) );
            end
            
            wz=obj.w(z);zR=obj.zR;
            ppl1=2*obj.p+obj.l+1;
            u=sqrt(2.0)*r/wz;
            
            val = obj.w0/obj.w(z) ...
                * exp(-r2/wz/wz) ...
                * exp(-1.j* k*r2/2.0/obj.R(z)) ...
                * u^obj.l * laguerreL(obj.p, abs(obj.l), u*u ) ...
                * exp(-1.j*obj.l*phi) ...
                * exp( 1.j*ppl1*obj.eta(z) );
            
        end
    end
    
end


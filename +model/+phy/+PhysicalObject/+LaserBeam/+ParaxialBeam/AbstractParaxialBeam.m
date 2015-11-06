classdef AbstractParaxialBeam < model.phy.PhysicalObject.LaserBeam.OpticalField
    %GAUSSIANBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        medium
        wavelength
        cross_area
        intensity
        power
        
        k
        
        w0
        zR
        rc
        abs_E0
    end
    
    methods
        function obj=AbstractParaxialBeam(wavelength, power, waist, center, medium_name)
            if nargin < 5
                medium_name = 'air';
            end
            obj.medium=model.phy.data.MediumData.get_parameters(medium_name);
            
            obj.wavelength=wavelength;      %wavelength in medium
            obj.k=2.0*pi/wavelength;        %wave number in medium
            
            obj.setPower( power, pi*waist*waist);
            obj.w0=waist;
            obj.zR=pi*waist*waist/wavelength;
            obj.rc= center;
            obj.abs_E0= sqrt(2.0*obj.intensity*obj.medium.Z);
        end
        
        function setPower(obj,  power, cross_area)
            obj.power=power;                %incident power in Walt
            obj.cross_area=cross_area;      % cross section area in m^2
            obj.intensity=power/cross_area; % beam intensity Walt/m2
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
        
    end
    
end


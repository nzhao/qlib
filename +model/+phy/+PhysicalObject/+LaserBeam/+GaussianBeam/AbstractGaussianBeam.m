classdef AbstractGaussianBeam < model.phy.PhysicalObject.LaserBeam.AbstractLaserBeam
    %GAUSSIANBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        wavelength
        intensity
        w0
        zR
        rc
        k
    end
    
    methods
        function obj=AbstractGaussianBeam(wavelength, intensity, waist, center)
            obj@model.phy.PhysicalObject.LaserBeam.AbstractLaserBeam('GaussianBeam');
            obj.wavelength=wavelength;
            obj.intensity=intensity;
            obj.w0=waist;
            obj.zR=pi*waist*waist/wavelength;
            obj.rc= center;
            obj.k=2.0*pi/wavelength;
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
        
        function [data, fig]=lineCut(obj, r0, r1, n)
            data=zeros(n+1, 4);
            x=zeros(1, n+1);
            y=zeros(1, n+1);
            dr=(r1-r0)/n;
            drNorm=norm(dr);
            
            for kk=1:n+1
                r=r0+(kk-1)*dr;
                x(kk)=(kk-1)*drNorm;
                y(kk)=obj.wavefunction(r(1), r(2), r(3));
                
                data(kk,:)=[r, y(kk)];
            end
            figure;
            fig=plot(x, abs(y));
        end
        
        function [data, fig]=slice(obj, r0, r1, r2, n1, n2)
            data=zeros( (2*n1+1)*(2*n2+1), 4);
            x=zeros( 1, (2*n1+1)*(2*n2+1));
            y=zeros( 1, (2*n1+1)*(2*n2+1));
            z=zeros( 1, (2*n1+1)*(2*n2+1));
            
            dr1= (r1-r0)/n1;
            dr2= (r2-r0)/n2;
            dr1Norm=norm(dr1);
            dr2Norm=norm(dr2);
            
            qq=0;
            for jj=-n1:n1
                disp(jj);
                for kk=-n2:n2
                    qq=qq+1;
                    r=r0+jj*dr1+kk*dr2;
                    x(qq)=jj*dr1Norm;
                    y(qq)=kk*dr2Norm;
                    z(qq)=obj.wavefunction(r(1), r(2), r(3));
                    data(qq, :)=[r, z(qq)];
                end
            end
            
            X=reshape(x, [2*n1+1, 2*n2+1]);
            Y=reshape(y, [2*n1+1, 2*n2+1]);
            Z=reshape(abs(z), [2*n1+1, 2*n2+1]);
            figure;
            fig=surf(X, Y, Z);
        end
    end
    
end


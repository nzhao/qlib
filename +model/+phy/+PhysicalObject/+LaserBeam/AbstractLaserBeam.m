classdef AbstractLaserBeam < model.phy.PhysicalObject.PhysicalObject
    %LASERBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        wavelength
        intensity
        k
    end
    
    
    methods
        function obj=AbstractLaserBeam(name, wavelength, intensity)
            obj.name=name;
            obj.wavelength=wavelength;
            obj.intensity=intensity;
            obj.k=2.0*pi/wavelength;
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
            fig=surf(X, Y, Z);
        end
        
    end
    
    
    methods (Abstract)
        wavefunction(obj, x, y, z)
        getVSWFcoeff(obj)
    end
end


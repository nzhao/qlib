classdef LinearCircularPol < model.phy.PhysicalObject.LaserBeam.AplanaticBeam.AbstractAplanaticBeam
    %LINEARCIRCULARPOL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        px
        py
        gs_order
    end
    
    methods
        function obj=LinearCircularPol(wavelength, intensity, f0, na, n1, n2, px, py, p, l)
            obj@model.phy.PhysicalObject.LaserBeam.AplanaticBeam.AbstractAplanaticBeam(wavelength, intensity, f0, na, n1, n2, p, l);
            obj.px=px;
            obj.py=py;
            obj.gs_order=GS_INT_ORDER;
        end
        
        function val=wavefunction(obj, x, y, z)
            [rho, phi, z1]=model.math.misc.Cart2Cylind(x, y, z);
            val1=obj.wavefunction_cylindrical(rho, phi, z1);
            val=val1(1:3)'*val1(1:3);
        end
        
        function val=wavefunction_cylindrical(obj, rho, phi, z)
            kz=obj.k*z;
            kr=obj.k*rho;
            px=obj.px; py=obj.py; %#ok<*PROP>
            
            [aList, wList]=obj.alpha_sampling(kz, kr);

            sinA=sin(aList); cosA=cos(aList); 
            sinA2=0.5-0.5*cosA; cosA2=0.5+0.5*cosA;  %sin^2(a/2) and cos^2(a/2)
            
            exp_kz=exp(1.j*kz*cosA);
            
            x=kr*sinA;  l=abs(obj.l);
            f1=besselj(l-2, x).*sinA2;
            f2=besselj(l+2, x).*sinA2;
            f3=besselj(l, x).*cosA2;
            f4=besselj(l-1, x).*sinA;
            f5=besselj(l+1, x).*sinA;
            

            y=sqrt(2.0)*obj.n2*sinA/obj.f0/obj.na;
            Pa=y.^l .* laguerreL(obj.p, l, y.*y);
            Qa=Pa.*exp(-y.*y).*sinA.*sqrt(cosA).*exp_kz;
            
            e1phi=exp(1.j*phi); e2phi=e1phi*e1phi; elphi=(1.j*e1phi)^l;
            e1phi1=e1phi'; e2phi1=e2phi';
            pp=px+1.j*py; pm=px-1.j*py;
            Z=1.;

            ex=Qa.*(pp*e2phi1.*f1 + pm*e2phi.*f2 + 2.0*px*f3) * 0.5*elphi;
            ey=Qa.*(pp*e2phi1.*f1 - pm*e2phi.*f2 - 2.0*py*f3) * 0.5*1.j*elphi;
            ez=Qa.*(pp*e1phi1.*f4 - pm*e1phi.*f5 )            * 0.5*1.j*elphi;
            
            hx=  Qa.*(pp*e2phi1.*f1 - pm*e2phi.*f2 + 2.0*1.j*py*f3) * 0.5*1.j*elphi/Z;
            hy= -Qa.*(pp*e2phi1.*f1 + pm*e2phi.*f2 - 2.0*px*f3)     * 0.5*elphi/Z;
            hz= -Qa.*(pp*e1phi1.*f4 + pm*e1phi.*f5 )                * 0.5*elphi/Z;
            
            val=[ex; ey; ez; hx; hy; hz]*wList';
        end
        
        function [aList, wList]=alpha_sampling(obj, kz, kr)
            nPiece=ceil(max([kz, kr, 1]));
            
            nOrder=obj.gs_order;
            aList=zeros(1, nPiece*nOrder);
            wList=zeros(1, nPiece*nOrder);
            dx=obj.aMax/nPiece;
            for kk=1:nPiece
                x1=(kk-1)*dx; x2=x1+dx;
                [x, w] = model.math.misc.lgwt(nOrder, x1, x2);
                aList( (kk-1)*nOrder+1: kk*nOrder ) = x;
                wList( (kk-1)*nOrder+1: kk*nOrder ) = w;
            end
        end
        
    end
    
end


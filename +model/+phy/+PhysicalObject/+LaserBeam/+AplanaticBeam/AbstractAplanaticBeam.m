classdef AbstractAplanaticBeam <  model.phy.PhysicalObject.LaserBeam.AbstractLaserBeam
    %ABSTRACTAPLANATICBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        lens
        incBeam
        
        f0
        gs_order
    end
    
    methods
        function obj=AbstractAplanaticBeam(lens, paraxial_inc_beam)
            obj@model.phy.PhysicalObject.LaserBeam.AbstractLaserBeam('AbstractAplanaticBeam',...
                paraxial_inc_beam.wavelength, paraxial_inc_beam.power, 1, 'air');
            
            obj.lens=lens;
            obj.incBeam=paraxial_inc_beam;

            obj.f0=paraxial_inc_beam.w0/lens.focal_distance/sin(lens.aMax);
            obj.gs_order=GS_INT_ORDER;
        end
        
        
        function val=wavefunction(obj, r, theta, phi)%#ok<INUSD>
            val= 0.0;
        end        
        
        function [a, b]=getVSWFcoeff(maxN)
            a=zeros(1, maxN);
            b=zeros(1, maxN);
        end
        
        function [aList, wList]=alpha_sampling(obj, nPiece)
            nOrder=obj.gs_order;
            aList=zeros(1, nPiece*nOrder);
            wList=zeros(1, nPiece*nOrder);
            dx=obj.lens.aMax/nPiece;
            for kk=1:nPiece
                x1=(kk-1)*dx; x2=x1+dx;
                [x, w] = model.math.misc.lgwt(nOrder, x1, x2);
                aList( (kk-1)*nOrder+1: kk*nOrder ) = x(end:-1:1);
                wList( (kk-1)*nOrder+1: kk*nOrder ) = w(end:-1:1);
            end            
        end
        
        function val=unitFactor(obj)
            f=obj.lens.focal_distance;
            abs_E0= obj.incBeam.abs_E0;
            k=obj.incBeam.k;

            ikf=1.j* k * f;
            eta_f= ikf*exp(-ikf);
            val=abs_E0*eta_f;
        end
        

    end

    
end


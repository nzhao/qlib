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
        gs_order
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
            dx=obj.aMax/nPiece;
            for kk=1:nPiece
                x1=(kk-1)*dx; x2=x1+dx;
                [x, w] = model.math.misc.lgwt(nOrder, x1, x2);
                aList( (kk-1)*nOrder+1: kk*nOrder ) = x(end:-1:1);
                wList( (kk-1)*nOrder+1: kk*nOrder ) = w(end:-1:1);
            end            
        end
    end

    
end


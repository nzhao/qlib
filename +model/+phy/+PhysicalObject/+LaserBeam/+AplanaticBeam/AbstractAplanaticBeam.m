classdef AbstractAplanaticBeam <  model.phy.PhysicalObject.LaserBeam.AbstractLaserBeam
    %ABSTRACTAPLANATICBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        p
        l
        f0
        na
        
        eps0
        mu0
        epsM
        muM
        n0
        nMedium
        Z
        
        aMax
        gs_order
    end
    
    methods
        function obj=AbstractAplanaticBeam(wavelength, intensity, f0, na, eps_0, mu_0, eps_medium, mu_medium, p, l)
            obj@model.phy.PhysicalObject.LaserBeam.AbstractLaserBeam('AbstractAplanaticBeam',wavelength, intensity);
            obj.f0=f0;
            obj.na=na;

            obj.eps0=eps_0;          % epsilon outside lens
            obj.mu0=mu_0;            % mu outside lens
            obj.epsM=eps_medium;
            obj.muM=mu_medium;
            obj.n0=sqrt(eps_0*mu_0);
            obj.nMedium=sqrt(eps_medium*mu_medium);
            obj.Z=sqrt(mu_medium/eps_medium)*Z0;
            
            obj.aMax=asin(na/mu_medium);
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


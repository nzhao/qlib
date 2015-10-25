classdef LinearCircularPol < model.phy.PhysicalObject.LaserBeam.AplanaticBeam.AbstractAplanaticBeam
    %LINEARCIRCULARPOL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        px
        py
    end
    
    methods
        function obj=LinearCircularPol(wavelength, intensity, f0, na, eps0, mu0, epsM, muM, px, py, p, l)
            obj@model.phy.PhysicalObject.LaserBeam.AplanaticBeam.AbstractAplanaticBeam(wavelength, intensity, f0, na, eps0, mu0, epsM, muM, p, l);
            obj.px=px;
            obj.py=py;
        end
        
        function val=wavefunction(obj, x, y, z)
            [rho, phi, z1]=model.math.misc.Cart2Cylind(x, y, z);
            val1=obj.wavefunction_cylindrical(rho, phi, z1);
            val=val1(1:3)'*val1(1:3);
        end
        
        function [a, b]=getVSWFcoeff(obj, maxN)
            [aList, wList]=obj.alpha_sampling(maxN);

            sinA=sin(aList); cosA=cos(aList); 
            Qa=obj.Qpl(obj.p, obj.l, sinA, cosA);
            
            a=zeros(2*maxN+1, maxN);
            b=zeros(2*maxN+1, maxN);
            for n=1:maxN
                for m=-n:n                    
                    [amn, bmn]=obj.vswf_coeff(m, n, Qa, cosA, wList);
                    a(m+maxN+1, n)=amn;
                    b(m+maxN+1, n)=bmn;
                end
            end
            
            [ai, aj, av]=find(a);
            [bi, bj, bv]=find(b);
            
            obj.aNNZ=[aj, ai-maxN-1, av];
            obj.bNNZ=[bj, bi-maxN-1, bv];
        end

        
    end
    
end


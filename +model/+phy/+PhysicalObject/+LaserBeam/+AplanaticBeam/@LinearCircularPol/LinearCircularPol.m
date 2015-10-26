classdef LinearCircularPol < model.phy.PhysicalObject.LaserBeam.AplanaticBeam.AbstractAplanaticBeam
    %LINEARCIRCULARPOL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=LinearCircularPol(lens, inc_beam)
            obj@model.phy.PhysicalObject.LaserBeam.AplanaticBeam.AbstractAplanaticBeam(lens, inc_beam);
        end
        
        function val=wavefunction(obj, x, y, z)
            [rho, phi, z1]=model.math.misc.Cart2Cylind(x, y, z);
            val1=obj.wavefunction_cylindrical(rho, phi, z1)*obj.amplitude_factor;
            val=val1(1:3)'*val1(1:3);
        end
        
        function [a, b]=getVSWFcoeff(obj, maxN)
            [aList, wList]=obj.alpha_sampling(maxN);

            sinA=sin(aList); cosA=cos(aList); 
            Qa=obj.Qpl(obj.incBeam.p, obj.incBeam.l, sinA, cosA);
            
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
            
            obj.focBeam.aNNZ=[aj, ai-maxN-1, av];
            obj.focBeam.bNNZ=[bj, bi-maxN-1, bv];
        end

        
    end
    
end


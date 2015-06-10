classdef VectorSphericalHarmonics < handle
    %VECTORSPHERICALHARMONICS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        l
        m
    end
    
    methods
        function obj=VectorSphericalHarmonics(l, m)
            obj.l=l;
            obj.m=m;
        end
        
        function [B, C, P]=BCP(obj, theta, phi)
            [B,C,P] = vsh(obj.l, obj.m,theta,phi);
        end
        
        function val=B(obj, theta, phi)
            [val, ~, ~]=obj.BCP(theta, phi);
        end
        
        function val=C(obj, theta, phi)
            [~, val, ~]=obj.BCP(theta, phi);
        end
        
        function val=P(obj, theta, phi)
            [~, ~, val]=obj.BCP(theta, phi);
        end
        
        function val=plot3d(obj, k)
            theta=0:pi/100:pi;
            phi=0:pi/50;2*pi;
            val=obj.BCP(theta, phi)
        end
    end
    
end


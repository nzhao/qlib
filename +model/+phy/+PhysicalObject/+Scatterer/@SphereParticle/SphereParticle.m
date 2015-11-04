classdef SphereParticle < model.phy.PhysicalObject.Scatterer.AbstractScatterer
    %SPHEREPARTICLE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nlayer
        radius
        medium
    end
    
    methods
        function obj=SphereParticle(radius, medium)
            obj@model.phy.PhysicalObject.Scatterer.AbstractScatterer([0, 0, 0], medium);
            if ischar(medium)
                medium={medium};
            end
            
            if length(radius)==length(medium)
                obj.nlayer=length(radius);
                obj.radius=radius;
                obj.medium=medium;
            else
                error('error: length does not match: length(radius)=%d, length(medium)=%d', length(radius), length(medium));
            end
        end
        
        function [t,t2,a,b] = tMatrix(obj, nmax, kVacuum, background_medium)
            if nargin < 3
                background_medium='vacuum';
            end
            
            bg=model.phy.data.MediumData.get_parameters(background_medium);
            k_bg=kVacuum*bg.n;
            
            k_particle=zeros(1, obj.nlayer);
            for ii=1:obj.nlayer
                layer_i=model.phy.data.MediumData.get_parameters(obj.medium{ii});
                k_particle(ii)=kVacuum*layer_i.n;
            end
            
            %[t,t2,a,b] = ott13.tmatrix_mie_layered(nmax,k_bg,k_particle,obj.radius);
            [t,t2,a,b] = ott13.tmatrix_mie(nmax,k_bg,k_particle,obj.radius);
        end
        
        
        function setPosition(obj, rVect)
            obj.position=rVect;
        end
        
        function rVect=getPosition(obj)
            rVect=obj.position;
        end
    end
    
end


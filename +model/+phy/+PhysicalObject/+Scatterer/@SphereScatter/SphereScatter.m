classdef SphereScatter < model.phy.PhysicalObject.Scatterer.AbstractScatterer
    %SPHERESCATTER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        radius%default 0.05um
    end
    
    methods
        function obj = SphereScatter(x,y,z,radius,scatter_medium)
            obj@model.phy.PhysicalObject.Scatterer.AbstractScatterer(x,y,z,scatter_medium);            
            obj.radius=radius;            
        end
    end
    
end

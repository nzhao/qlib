classdef SphereScatter < model.phy.PhysicalObject.Scatterer.AbstractScatterer
    %SPHERESCATTER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        radius%default 0.05um
    end
    
    methods
        function obj = SphereScatter(r_center,radius,scatter_medium)
            obj@model.phy.PhysicalObject.Scatterer.AbstractScatterer(r_center,scatter_medium);            
            obj.radius=radius;            
        end
    end
    
end

classdef AbstractScatterer < model.phy.PhysicalObject.PhysicalObject
    %ABSTRACTPARTICLE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x=0
        y=0
        z=0
        scatter_medium %default SiO2.
    end
    
    methods
        function obj = AbstractScatterer(x,y,z,scatter_medium)            
            obj.x=x;
            obj.y=y;
            obj.z=z;
            %             if nargin<4
            %                 scatter_medium='silica';
            %             end
            obj.scatter_medium=model.phy.data.MediumData.get_parameters(scatter_medium);
        end
    end
    
end


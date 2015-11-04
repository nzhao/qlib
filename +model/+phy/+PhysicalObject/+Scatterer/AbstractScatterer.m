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
        function obj = AbstractScatterer(r_center,scatter_medium)
            obj.x=r_center(1);
            obj.y=r_center(2);
            obj.z=r_center(3);
            %             if nargin<2
            %                 scatter_medium='silica';
            %             end
            obj.scatter_medium=model.phy.data.MediumData.get_parameters(scatter_medium);
        end
    end
    
end


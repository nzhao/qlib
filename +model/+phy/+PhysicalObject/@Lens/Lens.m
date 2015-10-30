classdef Lens < model.phy.PhysicalObject.PhysicalObject
    %LENS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        focal_distance
        work_medium
        inc_medium
        NA
        aMax
    end
    
    methods
        function obj=Lens(f, na, working_medium, incident_medium)
            obj.focal_distance=f*1000.0; % milli-meter to micron
            obj.NA=na;
            
            if nargin<4
                incident_medium='vacuum';
            end
            
            obj.work_medium =model.phy.data.MediumData.get_parameters(working_medium);
            obj.inc_medium  =model.phy.data.MediumData.get_parameters(incident_medium);

            obj.aMax=obj.MaxAlpha();
        end
        
        function val=MaxAlpha(obj)
            val=asin(obj.NA/obj.work_medium.n);
        end
    end
    
end


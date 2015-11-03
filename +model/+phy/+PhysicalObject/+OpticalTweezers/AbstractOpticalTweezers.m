classdef AbstractOpticalTweezers < model.phy.PhysicalObject.PhysicalObject
    %AbstractOpticalTweezers Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nScatterer
        
        lens
        incBeam
    end
    
    methods
        function obj=AbstractOpticalTweezers(lens, inc)
            obj.lens=lens;
            obj.incBeam=inc;
        end

    end
    
end


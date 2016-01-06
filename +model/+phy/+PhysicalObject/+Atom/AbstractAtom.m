classdef AbstractAtom < model.phy.PhysicalObject.PhysicalObject
    %ATOM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        parameters
        vilocity
    end
    
    methods
        function obj = AbstractAtom(name)
            obj.name=name;
        end
    end
    
end  


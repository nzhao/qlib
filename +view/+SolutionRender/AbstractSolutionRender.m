classdef AbstractSolutionRender < handle
    %ABSTRACTRESULTRENDER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        solution
    end
    
    methods
        function obj=AbstractSolutionRender(sol)
            obj.solution=sol;
        end
        
    end
    
    methods (Abstract)
        plot(obj, name, varargin)
        get_result(obj)
    end
    
end


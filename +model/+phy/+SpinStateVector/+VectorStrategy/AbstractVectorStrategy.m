classdef AbstractVectorStrategy < handle
    %ABSTRACTVECTORSTRATEGY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_collection
    end
    
    methods
        function obj=AbstractVectorStrategy(spin_collection)
            obj.spin_collection=spin_collection;
            
        end
    end
    
    methods (Abstract)
        calculate_vector(obj);
    end
    
end


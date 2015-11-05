classdef AbstractSpinStateVector < handle
    %ABSTRACTSPINSTATEVECTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dim
        vector
        hasVector
        vector_strategy
    end
    
    methods
        function generate_vector(obj)
            obj.vector=obj.vector_strategy.calculate_vector();
            obj.hasVector=1;
        end
        
        function vect=getVector(obj)
            if ~obj.hasVector
                obj.generate_vector();
            end
            vect=obj.vector;
        end
    end

end


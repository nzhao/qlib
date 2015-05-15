classdef AbstractQuantumOperator < handle
    %ABSTRACTQUANTUMOPERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        dim
        matrix
        matrix_strategy
    end
    
    methods
        function generate_matrix(obj)
            obj.matrix_strategy.initialize(obj);
            obj.matrix=obj.matrix_strategy.calculate_matrix();
        end
        
        function setName(obj, name)
            obj.name=name;
        end
        function name=getName(obj)
            name=obj.name;
        end
    end
    
end


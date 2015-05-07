classdef AbstractQuantumOperator
    %ABSTRACTQUANTUMOPERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dim
        matrix
        strategy
    end
    
    methods
        function generate_matrix(obj)
            obj.strategy.initilization();
            obj.matrix=obj.strategy.calculate_matrix();
        end
    end
    
end


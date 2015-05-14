classdef AbstractQuantumOperator < handle
    %ABSTRACTQUANTUMOPERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dim
        matrix
        matrix_strategy
    end
    
    methods
        function generate_matrix(obj)
            obj.matrix_strategy.initialize(obj);
            obj.matrix=obj.matrix_strategy.calculate_matrix();
        end
    end
    
end


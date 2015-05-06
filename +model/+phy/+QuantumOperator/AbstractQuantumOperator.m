classdef AbstractQuantumOperator
    %ABSTRACTQUANTUMOPERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dim
        matrix
    end
    
    methods (Abstract)
        generate_matrix(obj);
    end
    
end


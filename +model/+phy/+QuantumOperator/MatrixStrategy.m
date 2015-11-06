classdef MatrixStrategy < handle
    %HAMILTONIANSTRATEGY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Abstract)
        initialize(obj, qOperator);
        calculate_matrix(obj);
    end
    
end


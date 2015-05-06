classdef HamiltonianStrategy < handle
    %HAMILTONIANSTRATEGY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Abstract)
        calculate_matrix(obj);
    end
    
end


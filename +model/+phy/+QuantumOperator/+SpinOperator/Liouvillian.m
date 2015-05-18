classdef Liouvillian < model.phy.QuantumOperator.MultiSpinOperator
    %LIOUVILLIAN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=Liouvillian(spin_collection, matrix_strategy)
            obj@model.phy.QuantumOperator.MultiSpinOperator(spin_collection);
            if nargin > 1
                obj.matrix_strategy = matrix_strategy;
            end

        end
        
    end
    
end


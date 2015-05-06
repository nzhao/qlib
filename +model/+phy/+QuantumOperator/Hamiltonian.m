classdef Hamiltonian < model.phy.QuantumOperator.AbstractQuantumOperator
    %HAMILTONIAN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        strategy
    end
    
    methods
        function generate_matrix(obj)
            obj.matrix=obj.strategy.calculate_matrix();
        end
    end
    
end


classdef Liouvillian < model.phy.QuantumOperator.Hamiltonian
    %LIOUVILLIAN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=Liouvillian(spin_collection)
            obj@model.phy.QuantumOperator.Hamiltonian(spin_collection);
        end
        
    end
    
end


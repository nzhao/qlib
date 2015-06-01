classdef Hamiltonian < model.phy.QuantumOperator.MultiSpinOperator
    %HAMILTONIAN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        approximation
    end
    
    methods
        function obj=Hamiltonian(spin_collection, matrix_strategy)
            obj@model.phy.QuantumOperator.MultiSpinOperator(spin_collection);
            if nargin > 1
                obj.matrix_strategy = matrix_strategy;
            end
            obj.name='hamiltonian';
        end
        
        function remove_identity(obj, freq)
            if nargin < 2
                freq = trace(obj.getMatrix());
            end
            mat=obj.getMatrix()-freq/obj.dim*speye(obj.dim);
            obj.setMatrix(mat);
        end
        
        function addApproximation(obj, approximation)
                obj.approximation = approximation;
        end
        
        function apply_approximation(obj, approximation)
            if nargin > 1
                obj.addApproximation(approximation);
            end
            obj.approximation.apply(obj);
            
        end
    end
    
end


classdef SingleSpinUnitary < model.phy.QuantumOperator.AbstractQuantumOperator
    %SINGLESPINUNITARY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        unitary_matrix
    end
    
    methods
        function obj=SingleSpinUnitary(spin_collection, matrix_strategy, unitary_matrix)
            obj@model.phy.QuantumOperator.AbstractQuantumOperator();
            obj.spin_collection=spin_collection;
            obj.interaction_list={}; 
            
            if nargin < 2
                obj.matrix_strategy= model.phy.QuantumOperator.MatrixStrategy.FromProductSpace();
            else
                obj.matrix_strategy=matrix_strategy;
            end
            
            dim=length(unitary_matrix);
            diff=norm(unitary_matrix'*unitary_matrix-eye(dim), Inf);
            if diff > eps
                error('matrix is not unitary!');
            else
                obj.unitary_matrix=unitary_matrix;
            end
            
            uni_inte=model.phy.SpinInteraction.GeneralSpinInteraction(...
                spin_collection, { proj_spin_idx,}, { {unitary_matrix}, }, { 1.0,});
            
            obj.addInteraction(uni_inte);
            
        end
    end
    
end


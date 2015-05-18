classdef SingleSpinUnitary < model.phy.QuantumOperator.MultiSpinOperator
    %SINGLESPINUNITARY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        unitary_matrix
    end
    
    methods
        function obj=SingleSpinUnitary(spin_collection, unitary_matrix)
            obj@model.phy.QuantumOperator.MultiSpinOperator(spin_collection);
            
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


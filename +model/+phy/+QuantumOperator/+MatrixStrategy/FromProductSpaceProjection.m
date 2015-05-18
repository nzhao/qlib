classdef FromProductSpaceProjection < model.phy.QuantumOperator.MatrixStrategy.FromProductSpace
    %FROMPRODUCTSPACEPROJECTOIN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nProj
        projection_index
        projection_matrix
        orthognoal_states
        
        conditional_matrix
    end
    
    methods
        function obj=FromProductSpaceProjection(proj_spin_idx, orthognoal_states)
            obj.projection_index=proj_spin_idx;
            obj.orthognoal_states=orthognoal_states;
            [~, obj.nProj]=size(obj.orthognoal_states);
            obj.projection_matrix=cell(1, obj.nProj);
            obj.conditional_matrix=cell(1, obj.nProj);
        end
        
        function initialize(obj, qOperator)
            initialize@model.phy.QuantumOperator.MatrixStrategy.FromProductSpace(obj, qOperator);
            
            for k=1:obj.nProj
                state=obj.orthognoal_states(:, k);
                proj_op=model.phy.QuantumOperator.SingleSpinProjector(qOperator.spin_collection, obj.projection_index, state);
                proj_op.generate_matrix();
                obj.projection_matrix{k}=proj_op.matrix;
            end
        end
        
        function matrix=calculate_matrix(obj)
            full_mat=calculate_matrix@model.phy.QuantumOperator.MatrixStrategy.FromProductSpace(obj);
            
            matrix=0;
            for k=1:obj.nProj
                obj.conditional_matrix{k}=obj.projection_matrix{k}*full_mat*obj.projection_matrix{k};
                matrix=matrix+obj.conditional_matrix{k};
            end
        end
    end
    
end


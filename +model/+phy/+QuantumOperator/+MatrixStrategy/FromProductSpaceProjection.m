classdef FromProductSpaceProjection < model.phy.QuantumOperator.MatrixStrategy.FromProductSpace
    %FROMPRODUCTSPACEPROJECTOIN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nProj
        projection_index
        projection_matrix
        orthognoal_states
        
        unitary_op
        conditional_matrix
    end
    
    methods
        function obj=FromProductSpaceProjection(proj_spin_idx, orthognoal_states)
            obj.projection_index=proj_spin_idx;
            obj.orthognoal_states=orthognoal_states;
            
        end
        
        function initialize(obj, qOperator)
            initialize@model.phy.QuantumOperator.MatrixStrategy.FromProductSpace(obj, qOperator);
            obj.unitary_op=model.phy.QuantumOperator.SingleSpinUnitary(qOperator.spin_collection, obj.projection_index, obj.orthognoal_states);
            obj.unitary_op.generate_matrix();
        end
        
        
        function matrix=calculate_matrix(obj)
            full_mat=calculate_matrix@model.phy.QuantumOperator.MatrixStrategy.FromProductSpace(obj);
            u_mat=obj.unitary_op.matrix;
            u_full_mat= u_mat'*full_mat*u_mat;
            matrix=0;
            for k=1:obj.nProj
                index_list=obj.getIndex(obj.projection_index, state_k);
                obj.conditional_matrix{k}=u_full_mat(index_list, index_list);
                matrix=matrix+obj.conditional_matrix{k};
            end
        end
    end
    
end


classdef FromOperatorToSuperOperator < model.phy.QuantumOperator.MatrixStrategy
    %FROMOPERATORTOSUPEROPERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        interaction_list
        space
    end
    
    methods
        function initialize(obj, qOperator)
            obj.space=qOperator.spin_collection.getSpace();
            obj.interaction_list=qOperator.interaction_list;
            qOperator.dim=obj.space.dim;
        end
                
        function matrix=calculate_matrix(obj)
            matrix=sparse(0);
            nInteraction=length(obj.interaction_list);
            
            for k=1:nInteraction
                interaction_k=obj.interaction_list{k};
                interaction_matrix=obj.compute_interaction_matrix(interaction_k);
                matrix=matrix+interaction_matrix;
            end
        end
        
    end
    
end


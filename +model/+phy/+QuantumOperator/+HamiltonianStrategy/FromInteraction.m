classdef FromInteraction < model.phy.QuantumOperator.HamiltonianStrategy
    %FROMINTERACTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        interaction_list
    end
    
    methods
        function obj=FromInteraction()
            obj.interaction_list=[];
        end
        
        function addInteraction(obj, interaction)
            obj.interaction_list = [obj.interaction_list, interaction];
        end
        
        function matrix=calculate_matrix(obj)
            matrix=sparse(0);
            nInteraction=length(obj.interaction_list);
            
            for k=1:nInteraction
                interaction_k=obj.interaction_list(k);
                matrix=matrix+interaction_k.matrix();
            end
        end
    end
    
end


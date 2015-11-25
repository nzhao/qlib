classdef FromKronProd< model.phy.QuantumOperator.MatrixStrategy
    %FROMKRONPROD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        interaction_list
    end
    
    methods
        function initialize(obj, qOperator)
            obj.interaction_list=qOperator.interaction_list;
        end
        
        function skp=calculate_matrix(obj)
            nInteraction=length(obj.interaction_list);
            
            interaction_1=obj.interaction_list{1};
            skp=interaction_1.skp_form();
            for k=2:nInteraction
                interaction_k=obj.interaction_list{k};
                skp_k=interaction_k.skp_form();
                skp=skp+skp_k;
            end
        end
        
    end
    
end


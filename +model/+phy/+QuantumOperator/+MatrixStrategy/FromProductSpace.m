classdef FromProductSpace < model.phy.QuantumOperator.HamiltonianStrategy
    %FROMINTERACTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        interaction_list
        space
    end
    
    methods
        function initialize(obj, qOperator)
            obj.space=qOperator.spin_collection.getSpace();
            obj.interaction_list=qOperator.interaction_list;
        end
%         function obj=FromProductSpace(spin_collection)
%             obj.interaction_list=[];
%             obj.space=spin_collection.getSpace();
%         end
                
        function matrix=compute_interaction_matrix(interaction)
            row=[]; col=[]; val=[];
            iter=interaction.iter;
            while ~iter.isLast()
                obj.space.create_subspace( iter.currentIndex() );

                dimSub=obj.space.subspace.dim;
                dimQuot=obj.space.quotspace.dim;
                sub_in_full_table=zeros(dimSub,dimQuot);

                for j=1:dimSub
                    sub_in_full_table(j,:)=obj.space.locate_sub_basis(j);
                end

                spins=iter.currentItem();
                sub_matrix=interaction.calculate_matrix(spins);
                
                for j=1:dimSub
                    for k=1:dimSub
                        row=[row sub_in_full_table(j,:)]; %#ok<*AGROW>
                        col=[col sub_in_full_table(k,:)];
                        val=[val sub_matrix(j,k)*ones(1,dimQuot)];
                    end
                end                
                
            end
            
            matrix=sparse(row, col, val);
        end
                
        function matrix=calculate_matrix(obj)
            matrix=sparse(0);
            nInteraction=length(obj.interaction_list);
            
            for k=1:nInteraction
                interaction_k=obj.interaction_list(k);
                interaction_matrix=obj.compute_interaction_matrix(interaction_k);
                matrix=matrix+interaction_matrix;
            end
        end
    end
    
end


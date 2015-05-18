classdef MultiSpinOperator < model.phy.QuantumOperator.AbstractQuantumOperator
    %MULTISPINOPERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_collection
        interaction_list
    end
    
    methods
        function obj=MultiSpinOperator(spin_collection, matrix_strategy)
            obj.spin_collection=spin_collection;
            obj.interaction_list={};
            
            if nargin < 2
                obj.matrix_strategy= model.phy.QuantumOperator.MatrixStrategy.FromProductSpace();
            else
                obj.matrix_strategy=matrix_strategy;
            end
        end
        
        function addInteraction(obj, interaction)
            if interaction.isConsistent(obj.spin_collection);
                l=length(obj.interaction_list);
                obj.interaction_list{l+1} = interaction;
            else
                error('inconsistency detected.')
            end
        end
        
        function res_mat=transform(obj, transform_operator)
            transform_operator.generate_matrix();
            tMat=transform_operator.matrix;
            res_mat=tMat'*obj.matrix*tMat;
        end
        
        function proj_mat=project(obj, spin_sub_index, state)
            space=obj.spin_collection.getSpace();
            space.create_subspace(spin_sub_index);
            proj_index=space.locate_sub_basis(state);
            proj_mat=obj.matrix(proj_index, proj_index);
        end
        
    end
    
end


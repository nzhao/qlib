classdef MultiSpinSuperOperator < model.phy.QuantumOperator.AbstractQuantumOperator
    %MULTISPINSUPEROPERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_collection
        interaction_list
    end
    
    methods
        function obj=MultiSpinSuperOperator(spin_collection, matrix_strategy)
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

    end
    
end


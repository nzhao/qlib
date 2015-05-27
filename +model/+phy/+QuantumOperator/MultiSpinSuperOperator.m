classdef MultiSpinSuperOperator < model.phy.QuantumOperator.AbstractQuantumOperator
    %MULTISPINSUPEROPERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_collection
        interaction_list
    end
    
    methods
        function obj=MultiSpinSuperOperator(spin_collection, interaction_list)
            obj.spin_collection=spin_collection;
            if nargin > 1
                obj.interaction_list=interaction_list;
            else
                obj.interaction_list={};
            end
        end

    end
    
end


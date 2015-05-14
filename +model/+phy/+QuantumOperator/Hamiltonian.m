classdef Hamiltonian < model.phy.QuantumOperator.AbstractQuantumOperator
    %HAMILTONIAN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_collection
        interaction_list
    end
    
    methods
        function obj=Hamiltonian(spin_collection)
            obj.spin_collection=spin_collection;
            obj.interaction_list={};
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


classdef Liouvillian < model.phy.QuantumOperator.AbstractQuantumOperator
    %LIOUVILLIAN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_collection
        interaction_list
    end
    
    methods
        function obj=Liouvillian(spin_collection)
            obj.spin_collection=spin_collection;
            obj.interaction_list={};
        end
        
    end
    
end


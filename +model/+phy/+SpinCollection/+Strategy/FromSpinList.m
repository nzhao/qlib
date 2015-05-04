classdef FromSpinList < model.phy.SpinCollection.SpinCollectionStrategy
    %FROMSPINLIST Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_list
    end
    
    methods
        function obj = FromSpinList(spin_list)
            obj.spin_list = spin_list;
            obj.strategy_name = 'FromSpinList';
        end
        
        function spin_list = generate_spin_collection(obj)
            spin_list = num2cell(obj.spin_list);
        end        
    end
    
end


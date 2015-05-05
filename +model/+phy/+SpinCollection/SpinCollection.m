classdef SpinCollection < handle
    %SPINCOLLECTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_list
        strategy
    end
    
    methods
        function obj=SpinCollection()
            obj.spin_list = {};
        end
        
        function generate(obj)
            obj.spin_list = obj.strategy.generate_spin_collection();
        end
        
        function len=getLength(obj)
            len = length(obj.spin_list);
        end
    end
    
end


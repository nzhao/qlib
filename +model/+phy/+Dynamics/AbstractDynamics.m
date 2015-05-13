classdef AbstractDynamics < handle
    %ABSTRACTDYNAMICS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        time_list
        state_in
        state_out
        kernel
    end
    
    methods
        function obj=AbstractDynamics(kernel)
            obj.kernel=kernel;
        end
        
        function evolve(obj)
            obj.state_out=obj.kernel.calculate_evolution(obj.state_in, obj.time_list);
        end
        
        function set_initial_state(obj, state)
            obj.state_in=state;
        end
        
        function set_time_sequence(obj, time_list)
            obj.time_list=time_list;
        end
    end
    
end


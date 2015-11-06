classdef AbstractEvolutionKernel < handle
    %ABSTRACTEVOLUTIONKERNEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Abstract)
        state_out=calculate_evolution(obj, state_in, time_list)
        mean_val=mean_value(obj, obs);
    end
    
end


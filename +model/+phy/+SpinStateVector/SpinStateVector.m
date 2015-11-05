classdef SpinStateVector < model.phy.SpinStateVector.AbstractSpinStateVector
    %SPINSTATEVECTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=SpinStateVector(strategy)
            obj.hasVector=0;
            obj.vector_strategy=strategy;
        end
    end
    
end


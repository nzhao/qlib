classdef QuantumDynamics < model.phy.Dynamics.AbstractDynamics
    %QUANTUMDYNAMICS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=QuantumDynamics(kernel)
            obj@model.phy.Dynamics.AbstractDynamics(kernel);
        end
    end
    
end


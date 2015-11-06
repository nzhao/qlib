classdef AbstractSpinApproximation < handle
    %ABSTRACTSPINAPPROXIMATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_collection
    end
    
    methods (Abstract)
        apply(obj, hamiltonian)
    end
    
end


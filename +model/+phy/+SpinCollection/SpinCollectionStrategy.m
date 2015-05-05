classdef SpinCollectionStrategy < handle
    %SPINCOLLECTIONSTRAGEGY Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        strategy_name
    end
    
    methods (Abstract)
        generate_spin_collection(obj);
    end
    
end


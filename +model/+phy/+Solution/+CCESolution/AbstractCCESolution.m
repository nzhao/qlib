classdef AbstractCCESolution < model.phy.Solution.AbstractSolution
    %ABSTRACTCCESOLUTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        cluster_coherence_matrix
        cluster_coherence_tilde_matrix
        coherence
    end
    
    methods
        function obj=AbstractCCESolution(xml_file)            
            obj@model.phy.Solution.AbstractSolution(xml_file);
        end
    end
    
    methods (Abstract)
        ClusterCoherence(obj)
        CoherenceTotal(obj)
    end
    
end


classdef LinearSpace < handle
    %LINEARSPACE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dim
        full_basis
        
        %operators=containers.Map()
        operators
        %vectors=containers.Map()
        vectors
        %density_matices %state density matrix
        scalars
        %coherence etc...
        
        transfer_matrix
    end
    
    methods
        %constructor
        function obj=LinearSpace(dim, full_basis)
            if nargin>0
                obj.dim=dim;
                obj.full_basis=full_basis;                
            end
        end
        
    end
    
end


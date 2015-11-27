classdef AbstractQuantumOperator < handle
    %ABSTRACTQUANTUMOPERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        dim
        matrix
        matrix_strategy
        
        hasMatrix=0
    end
    
    methods
        function generate_matrix(obj, mat)
            if nargin > 1
                obj.matrix=mat;
            else
                obj.matrix_strategy.initialize(obj);
                obj.matrix=obj.matrix_strategy.calculate_matrix();
            end
            obj.hasMatrix=1;
        end
        
        function setName(obj, name)
            obj.name=name;
        end
        function name=getName(obj)
            name=obj.name;
        end
        
        function mat=getMatrix(obj)
            if ~obj.hasMatrix
                obj.generate_matrix();
            end
            mat=obj.matrix;
        end
        
        function setMatrix(obj, mat)
            obj.matrix=mat;
            obj.hasMatrix=1;
        end        
    end
    
end


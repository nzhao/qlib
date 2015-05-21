classdef DensityMatrix < model.phy.QuantumOperator.MultiSpinOperator
    %DENSITYMATRIX Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=DensityMatrix(spin_collection, str)
            obj@model.phy.QuantumOperator.MultiSpinOperator(spin_collection);
            if nargin > 1
                obj.addInteraction(model.phy.SpinInteraction.InteractionString(spin_collection, str));
            end
            
        end
        
        function generate_matrix(obj)
            generate_matrix@model.phy.QuantumOperator.MultiSpinOperator(obj);
            
            mat=obj.getMatrix();
            obj.setMatrix(mat/trace(mat));
        end        
                
    end
    
end


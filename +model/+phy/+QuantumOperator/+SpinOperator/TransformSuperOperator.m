classdef TransformSuperOperator < model.phy.QuantumOperator.MultiSpinSuperOperator
    %TRANSFORMATIONSUPEROPERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ts_matrix_single
    end
    
    methods
        function obj=TransformSuperOperator(spin_collection,varargin)
            obj@model.phy.QuantumOperator.MultiSpinSuperOperator(spin_collection);
            
            if nargin == 1
               obj.set_matrix_strategy();
            elseif nargin>1
                obj.matrix_strategy = matrix_strategy;
            end
            obj.name='transfer_superoperator';
        end
        
        function set_matrix_strategy(obj)
            % This function gives the transformation matrix for a single 1/2-spin from the IST basis to the natural basis 
            % or inverse transformation. For 1/2-spin, the  the IST basis is composed of:
            % |0)=[1/sqrt(2);0;0;1/sqrt(2)]; |1)=[0;1;0;0]; |2)=[0;0;1;0]; |3)=[1/sqrt(2);0;0;-1/sqrt(2)]
            % The natural basis is composed of:
            % |0)=[1;0;0;0]; |1)=[0;1;0;0];|2)=[0;0;1;0];|3)=[0;0;0;1]
            % It is easy to find that its inverse matrix is itself, i.e.,
            % ts_mat^(-1)=ts_mat;
                  
            strategy=model.phy.QuantumOperator.MatrixStrategy.FromKronProd();
            obj.matrix_strategy = strategy;
            nspin=obj.spin_collection.getLength;
            str='1.0 * ISTmatrix()_1';
            for kk=2:nspin
                str=[str ' * ISTmatrix()_' num2str(kk)];
            end
            obj.addInteraction(model.phy.SpinInteraction.InteractionString(obj.spin_collection, str));
                        
        end

    end
    
end


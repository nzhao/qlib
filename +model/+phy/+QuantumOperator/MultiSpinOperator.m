 classdef MultiSpinOperator < model.phy.QuantumOperator.AbstractQuantumOperator
    %MULTISPINOPERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_collection
        interaction_list
    end
    
    methods
        function obj=MultiSpinOperator(spin_collection, matrix_strategy)
            obj.spin_collection=spin_collection;
            obj.interaction_list={};
            obj.dim=spin_collection.getDim();
            
            if nargin < 2
                obj.matrix_strategy= model.phy.QuantumOperator.MatrixStrategy.FromProductSpace();
            else
                obj.matrix_strategy=matrix_strategy;
            end
        end
        
        function addInteraction(obj, interaction)
            if interaction.isConsistent(obj.spin_collection);
                l=length(obj.interaction_list);
                obj.interaction_list{l+1} = interaction;
            else
                error('inconsistency detected.')
            end
        end
        
        function v=getVector(obj)
            mat=obj.getMatrix();
            v=mat(:);
        end
        
        function res_mat=transform(obj, transform_operator)
            transform_operator.generate_matrix();
            tMat=transform_operator.getMatrix();
            res_mat=tMat'*obj.getMatrix()*tMat;
        end
        
        
        
        
        function proj_mat=project_matrix(obj, spin_sub_index, state)
            space=obj.spin_collection.getSpace();
            space.create_subspace(spin_sub_index);
            proj_index=space.locate_sub_basis(state);
            mat=obj.getMatrix();
            proj_mat=mat(proj_index, proj_index);
        end
        
        function proj_operator=project_operator(obj, spin_sub_index, state, name)
            mat=obj.project_matrix(spin_sub_index, state);
            
            spin_list=obj.spin_collection.spin_list;
            for k=1:length(spin_sub_index)
                spin_list(spin_sub_index(k))=[];
            end
            sc=model.phy.SpinCollection.SpinCollection();
            sc.spin_list=spin_list;
            
            operator_class=str2func(class(obj));
            proj_operator=operator_class(sc);
            proj_operator.setMatrix(mat);
            
            
            if nargin < 4
                name=[obj.name, '_', num2str(spin_sub_index), '_', num2str(state)];                
            end
            proj_operator.setName(name);
        end
        
        
        
        
        function super_operator=sharp(obj)
            super_operator=model.phy.QuantumOperator.MultiSpinSuperOperator(obj.spin_collection, obj.interaction_list);
            
            Bmat=obj.getMatrix(); eyeMat=speye(obj.dim);
            super_operator.setMatrix(kron(Bmat.', eyeMat));
        end
        
        function super_operator=flat(obj)
            super_operator=model.phy.QuantumOperator.MultiSpinSuperOperator(obj.spin_collection, obj.interaction_list);
            
            Amat=obj.getMatrix(); eyeMat=speye(obj.dim);
            super_operator.setMatrix(kron(eyeMat, Amat));
        end
        
        function super_operator=circleC(obj)
            super_operator=model.phy.QuantumOperator.MultiSpinSuperOperator(obj.spin_collection, obj.interaction_list);
            
            Cmat=obj.getMatrix(); eyeMat=speye(obj.dim);
            super_operator.setMatrix(kron(eyeMat, Cmat)-kron(conj(Cmat), eyeMat));
        end
        
        function super_operator=flat_sharp(obj, sharp_op)
            super_operator=model.phy.QuantumOperator.MultiSpinSuperOperator(obj.spin_collection, obj.interaction_list);
            
            Amat=obj.getMatrix(); Bmat=sharp_op.getMatrix();
            super_operator.setMatrix(kron(Bmat.', Amat));
        end
        
        function super_operator=flat_sharp_circleC(obj, sharp_op)
            super_operator=model.phy.QuantumOperator.MultiSpinSuperOperator(obj.spin_collection, obj.interaction_list);
            
            Amat=obj.getMatrix(); Bmat=sharp_op.getMatrix(); eyeMat=speye(obj.dim);
            super_operator.setMatrix(kron(Bmat.', eyeMat)-kron(eyeMat, Amat));
        end

    end
    
end

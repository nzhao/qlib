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
            obj.dim=spin_collection.getDim;
            
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
        
        function data=interaction_data(obj)
            nInt=length(obj.interaction_list);
            data=[];
            for ii=1:nInt
                interaction=obj.interaction_list{ii};
                data=[data, interaction.data_cell()];
            end
        end
        
        function export_interaction_data(obj, filename)
            data=obj.interaction_data;
            nSpin=length(obj.spin_collection.spin_list);
            nInt=length(data);

            fileID = fopen(filename,'w');
            fwrite(fileID, nSpin,'uint64');
            fwrite(fileID, nInt,'uint64');
            fwrite(fileID, obj.dim,'uint64');
            
            spin_dim=zeros(1, nSpin);
            for ii=1:nSpin
                spin=obj.spin_collection.spin_list{ii};
                spin_dim(ii)=spin.dim;
            end
            fwrite(fileID, spin_dim,'uint64');
            
            coeff_list=zeros(1, nInt);
            nbody_list=zeros(1, nInt);
            for ii=1:nInt
                data_i=data{ii};
                coeff_list(ii)=data_i{1};
                nbody_list(ii)=data_i{2};
            end
            total_nbody=sum(nbody_list);
            fwrite(fileID, coeff_list,'double');
            fwrite(fileID, nbody_list,'uint64');
            
            idx=1;
            pos_list=zeros(1, total_nbody);
            dim_list=zeros(1, total_nbody);
            for ii=1:nInt 
                data_i=data{ii};
                for kk=0:nbody_list(ii)-1
                    pos_list(idx)=data_i{3+kk*3};
                    dim_list(idx)=data_i{3+kk*3+1};
                    idx=idx+1;
                end
            end
            fwrite(fileID, pos_list-1,'uint64');%for C applications: count from 0 
            fwrite(fileID, dim_list,'uint64');

            for ii=1:nInt
                data_i=data{ii};
                for kk=0:nbody_list(ii)-1
                    mat_k=data_i{3+kk*3+2}; 
                    fwrite(fileID, real(mat_k),'double'); 
                end
            end
            for ii=1:nInt
                data_i=data{ii};
                for kk=0:nbody_list(ii)-1
                    mat_k=data_i{3+kk*3+2}; 
                    fwrite(fileID, imag(mat_k),'double'); 
                end
            end
            
            fclose(fileID);
        end
            
        
        function v=getVector(obj)
            mat=obj.getMatrix();
            v=mat(:);
        end
                
        function transform(obj, transform_operator)
            tMat=transform_operator.getMatrix();
            res_mat=tMat'*obj.getMatrix()*tMat;
            obj.setMatrix(res_mat);
        end
        
        function transform2selfEigenBases(obj)
            ts=obj.spin_collection.selfEigenTransform();
            obj.transform(ts);
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
            
            if isa(obj.matrix_strategy, 'model.phy.QuantumOperator.MatrixStrategy.FromKronProd')
                super_operator.name=[obj.name, '_sharp'];
                super_operator.setMatrix(obj.matrix.sharp);
            else
                Bmat=obj.getMatrix(); eyeMat=speye(obj.dim);
                super_operator.setMatrix(kron(Bmat.', eyeMat));
            end
        end
        
        function super_operator=flat(obj)
            super_operator=model.phy.QuantumOperator.MultiSpinSuperOperator(obj.spin_collection, obj.interaction_list);
            
            if isa(obj.matrix_strategy, 'model.phy.QuantumOperator.MatrixStrategy.FromKronProd')
                super_operator.name=[obj.name, '_flat'];
                super_operator.setMatrix(obj.matrix.flat);
            else
                Amat=obj.getMatrix(); eyeMat=speye(obj.dim);
                super_operator.setMatrix(kron(eyeMat, Amat));
            end
        end
        
        function super_operator=circleC(obj)
            super_operator=model.phy.QuantumOperator.MultiSpinSuperOperator(obj.spin_collection, obj.interaction_list);
            
            if isa(obj.matrix_strategy, 'model.phy.QuantumOperator.MatrixStrategy.FromKronProd')
                super_operator.name=[obj.name, '_circleC'];
                super_operator.setMatrix(obj.matrix.circleC);
            else
                Cmat=obj.getMatrix(); eyeMat=speye(obj.dim);
                super_operator.setMatrix(kron(eyeMat, Cmat)-kron(conj(Cmat), eyeMat));
            end
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


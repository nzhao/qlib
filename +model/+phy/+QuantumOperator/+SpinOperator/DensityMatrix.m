classdef DensityMatrix < model.phy.QuantumOperator.MultiSpinOperator
    %DENSITYMATRIX Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=DensityMatrix(spin_collection,matrix_strategy,str)           
            obj@model.phy.QuantumOperator.MultiSpinOperator(spin_collection,matrix_strategy);                   
            if nargin > 2
                obj.addInteraction(model.phy.SpinInteraction.AdditionalSpinInteraction.InteractionString(spin_collection, str));
            end            
        end
        
        function generate_matrix(obj)
            generate_matrix@model.phy.QuantumOperator.MultiSpinOperator(obj);
            mat_kp_sum=obj.getMatrix();            
            normal_factoer=obj.cal_normalization_coeff;
            npart=length(normal_factoer);
            
            if npart==1
                mat_kp_sum=normal_factoer*mat_kp_sum;
                
            elseif npart>1
                if ~(npart==mat_kp_sum.nProd)
                    error('Not Equal length.');
                end
                for kk=1:npart 
                    new_kp=normal_factoer(kk)*mat_kp_sum.kron_prod_cell{kk};
                    mat_kp_sum.kron_prod_cell{kk}=new_kp;
                end
            end
            
            
            obj.setMatrix(mat_kp_sum);
        end
        
        function normal_factoer=cal_normalization_coeff(obj)
            dim_list=obj.spin_collection.getDimList;
            dim=obj.dim;
            index_list=obj.interaction_list{1}.iter.index_list;
            npart=length(index_list);
            normal_factoer=zeros(1,npart);
            
            for kk=1:npart
                idx=index_list{kk};
                normal_factoer(kk)=prod( dim_list(idx) )/dim;                
            end
            
        end
                
    end
    
end


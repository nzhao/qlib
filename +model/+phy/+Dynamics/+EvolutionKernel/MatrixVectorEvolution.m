classdef MatrixVectorEvolution < model.phy.Dynamics.AbstractEvolutionKernel
    %MATRIXVECTOREVOLUTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        matrix
        result
        matrix_prefactor
    end
    
    methods
        function obj=MatrixVectorEvolution(qOperator, prefactor)
            try
                obj.matrix=qOperator.getMatrix();
            catch
                error([class(qOperator), 'does not have a property of matrix']);
            end
            obj.result=[];
            
            if nargin > 1
                obj.matrix_prefactor= prefactor;
            else
                obj.matrix_prefactor= -1.j;
            end
        end
        
        function state_out=evolve_step(obj, state_in, dt)
            state_out=expv(dt, obj.matrix_prefactor*obj.matrix, state_in);
        end
        
        function state_out=calculate_evolution(obj, state_in, time_list)
            nInterval=length(time_list)-1;
            
            state=state_in;
            for k=1:nInterval
                fprintf('calculating evolution from t=%e to t=%e...\n', time_list(k), time_list(k+1));
                dt=time_list(k+1)-time_list(k);
                state_out=obj.evolve_step(state, dt);                
                state=state_out;
                
                obj.result=[obj.result, state_out];
            end
        end
        
        function mean_val=mean_value(obj, obs_list)
            [len_res_dim, ~]=size(obj.result);
            len_obs=length(obs_list);
            
            obs_mat=zeros(len_obs, len_res_dim);
            for k=1:len_obs
                obs_mat(k,:)=obs_list(k).vector';
            end
            mean_val=obs_mat*obj.result;
        end
        
    end
    
end


classdef MatrixVectorEvolution < model.phy.Dynamics.AbstractEvolutionKernel
    %MATRIXVECTOREVOLUTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        matrix
        result=[]
    end
    
    methods
        function obj=MatrixVectorEvolution(qOperator)
            try
                obj.matrix=qOperator.matrix;
            catch
                error([class(qOperator), 'does not have a property of matrix']);
            end
        end
        
        function state_out=evolve_step(obj, state_in, dt)
            state_out=expv(dt, -1.j*obj.matrix, state_in);
        end
        
        function state_out=calculate_evolution(obj, state_in, time_list)
            nInterval=length(time_list)-1;
            
            state=state_in;
            for k=1:nInterval
                dt=time_list(k+1)-time_list(k);
                state_out=obj.evolve_step(state, dt);                
                state=state_out;
                
                obj.result=[obj.result, state_out];
            end
        end
        
    end
    
end


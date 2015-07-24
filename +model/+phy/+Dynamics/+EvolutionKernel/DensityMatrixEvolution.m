classdef DensityMatrixEvolution< model.phy.Dynamics.AbstractEvolutionKernel
    %ENSEMBLECCE 
    %This class is used to calculate the time evolutuion of the density
    %matrix in the Hilbert Spase
    
    properties
        timelist
        matrix_prefactor
        matrixList
        result
    end
    
    methods
          function obj=DensityMatrixEvolution(qoperatorList, prefactor)
              noperator=length(qoperatorList);
               if nargin>1
                   obj.matrix_prefactor=prefactor;
               else
                   obj.matrix_prefactor=[-1,1];
               end
               
               obj.matrixList=cell(1,noperator);

               for n=1:noperator
                   obj.matrixList{1,n}=obj.matrix_prefactor(n)*qoperatorList{n}.getMatrix();
               end
                obj.result=0;
          end
                 
          function state_out = calculate_evolution(obj, state_in, timelist)
               obj.timelist=timelist;
               ntime=length(timelist);
               dt=timelist(2)-timelist(1);

               noperator=length(obj.matrixList);
               core_mat_list=cell(1,noperator);
               evolution_mat_list=cell(1,noperator);
               for m=1:noperator %initial the core matrice                  
                   core_mat_list{m}=expm(1i*dt*obj.matrixList{1,m});
                   evolution_mat_list{m}=1;
               end
               state_out=cell(1,ntime);
               state_out{1,1}=state_in;
               for n=2:ntime                   
                   for m=1:noperator                      
                     evolution_mat_list{1,m}=evolution_mat_list{1,m}*core_mat_list{1,m};
                   end
                   mat=1;
                  for m=1:noperator
                   if m==noperator/2
                       mat=mat*evolution_mat_list{1,m}*state_in;
                   else
                       mat=mat*evolution_mat_list{1,m};
                   end
                  end
                  state_out{1,n}=mat;
               end
                obj.result=state_out;
          end
                   

          function  mean_val=mean_value(obj, obs_list)
              ntime=length(obj.timelist);
              len_obs=length(obs_list);
              mean_val=zeros(len_obs,ntime);
              for n=1:len_obs
                  mat=obs_list{n}.getMatrix;
                  mean_val(n,:)=cellfun(@(s) trace(s*mat), obj.result);
              end
          end
          
    end
    
end


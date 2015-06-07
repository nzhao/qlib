classdef DensityMatrixEvolution< model.phy.Dynamics.AbstractEvolutionKernel
    %ENSEMBLECCE 
    %This class is used to calculate the time evolutuion of the coherence for ensemble CCE method 
    
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
                coh_mat_list=cell(1,noperator);   
                for m=1:noperator %initial the core matrice
                     core=1i*dt*obj.matrixList{1,m};
                     coh_mat_list{m}=model.math.linear_sequence_expm(core,ntime-1,1);
                end
                
               state_out=cell(1,ntime);
               for n=1:ntime
                   mat=1;
                   for m=1:noperator
                       if m==noperator/2
                           mat=mat*coh_mat_list{m}{n}*state_in;
                       else
                           mat=mat*coh_mat_list{m}{n};
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


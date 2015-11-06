classdef ObservableMatrixEvolution < model.phy.Dynamics.AbstractEvolutionKernel
    %OBSERVABLEEVOLUTION Summary of this class goes here
    %For a large system, it not possible to save all density matrix for a given time list 
    %This class is used to calculate the values of given observalbes directly in the Hilbert Spase
    %without saving the density matrix for different time

    
    properties
        timelist
        matrix_prefactor
        matrixList
        initial_state
        core_mat_list%evolution core matrix list = exp(-i*prefactor*H*dt)
        result
    end
    
    methods
          function obj=ObservableMatrixEvolution(qoperatorList, prefactor)
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
        
          function out_put=calculate_evolution(obj, state_in, timelist)
              % actually, the time evolution does not take place at this moment
               obj.timelist=timelist;
               dt=timelist(2)-timelist(1);
               obj.initial_state=state_in;
               
               noperator=length(obj.matrixList);
               obj.core_mat_list=cell(1,noperator);
               for m=1:1:noperator                  
                   obj.core_mat_list{1,m}=expm(1i*dt*obj.matrixList{1,m});
               end
               out_put=state_in;
          end
                   

          function  mean_val=mean_value(obj, obs_list)
              ntime=length(obj.timelist);
              len_obs=length(obs_list);
              mean_val=zeros(len_obs,ntime);
              for n=1:len_obs
                  mat=obs_list{n}.getMatrix;
                  mean_val(n,:)=obj.cal_mean_value(mat);
              end
          end
          function value=cal_mean_value(obj,obs_mat)
              ntime=length(obj.timelist); 
              value=zeros(1,ntime);              
              state_in=obj.initial_state;
              value(1,1)=trace(obs_mat*state_in);
              
              noperator=length(obj.core_mat_list);              
              evolution_mat_list=cell(1,noperator);
              for m=1:noperator
                  evolution_mat_list{1,m}=1;
              end

              for n=2:ntime  
                  mat=1;
                  for m=1:noperator                      
                     evolution_mat_list{1,m}=evolution_mat_list{1,m}*obj.core_mat_list{1,m};
                  end

                  for m=1:noperator
                       if m==noperator/2
                           mat=mat*evolution_mat_list{1,m}*state_in;
                       else
                           mat=mat*evolution_mat_list{1,m};
                       end
                  end;
                    value(1,n)=trace(obs_mat*mat);
               end

          end
          
    end
    
end




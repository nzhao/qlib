classdef ECCEMatrixEvolution< model.phy.Dynamics.AbstractEvolutionKernel
    %ENSEMBLECCE 
    %This class is used to calculate the time evolutuion of the coherence for ensemble CCE method 
    
    properties
        timelist
        npulse
        secular_approx
        hami_state1
        hami_state2
        result
    end
    
    methods
          function obj=ECCEMatrixEvolution(hami_cluster, para)
                try
                    state1=para.state1; 
                    state2=para.state2;
                catch
                    error([class(para), 'does not have two given states of the central spin']);
                end
%                 try
%                     tmax=para.tmax;ntime=para.ntime;
%                     obj.dt=tmax/(ntime-1);obj.timelist=0:obj.dt:tmax;
%                 catch
%                     error([class(para), 'does not have a correct time parameters']);
%                 end
                try
                    obj.npulse=para.npulse;
                catch
                    obj.npulse=0;
                end
                try
                    obj.secular_approx=para.secular_approx;
                catch
                    obj.secular_approx=0;
                end
%                 hami_cluster.addInteraction( ZeemanInteraction(cluster) );
%                 hami_cluster.addInteraction( DipolarInteraction(cluster) );
%                 ts=model.phy.QuantumOperator.SpinOperator.TransformOperator(cluster,{'1.0 * eigenVectors()_1'});
%                 hami_cluster.transform(ts);
                hami1=hami_cluster.project_operator(1, state1);
                hami2=hami_cluster.project_operator(1, state2);
                hami1.remove_identity(); 
                hami2.remove_identity(); 
                if obj.secular_approx && length(hami_cluster.spin_collection.spin_list)>2
                    approx1=model.phy.SpinApproximation.SpinSecularApproximation(hami1.spin_collection);
                    approx2=model.phy.SpinApproximation.SpinSecularApproximation(hami2.spin_collection);
                    hami1.apply_approximation(approx1);     
                    hami2.apply_approximation(approx2);
                end
                obj.hami_state1=hami1;    
                obj.hami_state2=hami2;
                obj.result=0;
          end
          
          function coh = calculate_evolution(obj, state_in, timelist)
                obj.timelist=timelist;
                ntime=length(timelist);
                dt=timelist(2)-timelist(1);
                hami1=obj.hami_state1.getMatrix;
                hami2=obj.hami_state2.getMatrix;

                time_seq=obj.time_ratio_seq();
                len_time_seq=length(time_seq);
                p_list=(1:len_time_seq)+obj.npulse;
                parity_list=rem(p_list,2);

               coh_mat_list=cell(1,len_time_seq);   
                for m=1:len_time_seq %initial the core matrice
                     parity=parity_list(m); 
                     switch parity
                            case 0
                                hami=hami1;
                            case 1
                                hami=hami2;
                            otherwise
                                error('wrong parity of the index of the hamiltonian sequence.');
                     end
                     core=expm(1i*dt*hami*time_seq(m));
                     coh_mat_list{m}=model.math.linear_sequence_expm(core,ntime-1,1);
                end
                
               coh=ones(1,ntime);
               for n=1:ntime
                   coh_mat=1;
                   for m=1:len_time_seq
                       coh_mat=coh_mat*coh_mat_list{m}{n};
                   end
                   coh(n)=trace(coh_mat);
               end
               obj.result=coh;
          end
                   
          function time_seq= time_ratio_seq(obj)
                np=obj.npulse;
                if np==0
                    time_seq=[1,-1];
                elseif np>0
                    nsegment=obj.npulse+1;
                    step=1/np/2;
                    seq=zeros(1,nsegment);
                    for n=1:nsegment
                        if n==1
                            seq(1,n)=step;
                        elseif n==nsegment
                            seq(1,n)=step;
                        else
                            seq(1,n)=2*step;
                        end
                    end
                    time_seq=[seq,-1*seq];
                end     
            end
          function  mean_val=mean_value(obj, obs)
              disp('there is observables for ensemble CCE');
              dim=obs.dim;
              obj.result=obj.result/dim;
              mean_val=obj.result;
          end
          
    end
    
end


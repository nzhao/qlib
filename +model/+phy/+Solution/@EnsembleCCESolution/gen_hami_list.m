function  [hami_list,time_seq]= gen_hami_list( obj,hamiCell)
% Generate hamiltonian list for the evolution of ensemble CCE with a given pulse number
        npulse=obj.parameters.NPulse; 
        time_seq=time_ratio_seq(npulse);
        len_time_seq=length(time_seq);
        hami_list=cell(1,len_time_seq);
        p_list=(1:len_time_seq)+npulse;
        parity_list=rem(p_list,2);
        for m=1:len_time_seq %initial the core matrice
             parity=parity_list(m); 
             switch parity
                    case 0
                        hami=hamiCell{1,1};                       
                    case 1
                        hami=hamiCell{1,2};
                    otherwise
                        error('wrong parity of the index of the hamiltonian sequence.');
             end
             hami_list{m}=hami;
        end
end

function time_seq= time_ratio_seq(npulse)
    if npulse==0
        time_seq=[-1,1];
    elseif npulse>0
        nsegment=npulse+1;
        step=1/npulse/2;
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
        time_seq=[-1*seq,seq];
    end     
end
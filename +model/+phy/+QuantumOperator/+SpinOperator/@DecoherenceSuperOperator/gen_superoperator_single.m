function L_single=gen_superoperator_single(obj,spin,kk)
    Gamma_v=obj.decay_rate_list.Gamma_vertical_list(kk);% the vertical decay rate 
    Gamma_p=obj.decay_rate_list.Gamma_parallel_list(kk);% the parallel decay rate

    if Gamma_v >0 || Gamma_p > 0
        nspin=obj.spin_collection.getLength;
        dim_list=obj.spin_collection.getDimList;
        dim_tot=obj.spin_collection.getDim;
 
        %% generate ladder operators
        sigma_m=1;%sigma_minus
        sigma_p=1;%sigma_plus
        sigma_z=1;
        for mm=1:nspin
            if mm==kk
                mat_m=sparse([0,0;1,0]);
                mat_p=sparse([0,1;0,0]);
                mat_z=sparse([1,0;0,-1]);
            else
                mat_m=speye(dim_list(mm));
                mat_p=speye(dim_list(mm));
            end
            sigma_m=kron(sigma_m,mat_m);    
            sigma_p=kron(sigma_p,mat_p);
            sigma_z=kron(sigma_z,mat_z);
        end

        %% generate supperoperator for the current spin
        if Gamma_v>0            
            % ocupation number of the bath mode
            eigen_vals=spin.eigen_val;
            omega=abs(eigen_vals(1)-eigen_vals(2));% the spin has only two eigen values
            condition=model.phy.LabCondition.getCondition;
            temperature=condition.getValue('temperature');
            if temperature==0
                f_omega=0;
            else
                f_omega=1/(exp(hbar*omega/kB/temperature)-1);
            end
            
            L_v=0.5*Gamma_v*(f_omega+1)*(2*kron(sigma_p',sigma_m)-kron(speye(dim_tot),sigma_p*sigma_m)-kron((sigma_p*sigma_m)',speye(dim_tot)))...
                +0.5*Gamma_v*f_omega*(2*kron(sigma_m',sigma_p)-kron(speye(dim_tot),sigma_m*sigma_p)-kron((sigma_m*sigma_p)',speye(dim_tot)));
            %In the kron product, we have used the Hermitian conjugation to replace the transpose operation. because all the matrix is real
           
        else
           L_v=0; 
        end
        
        if Gamma_p>0
            L_p=0.5*Gamma_p*(kron(sigma_z',sigma_z)-speye(dim_tot^2));
        else
            L_p=0; 
        end
        L_single=sparse(L_v+L_p);
    else
       L_single=0;
    end

end
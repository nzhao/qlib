function L_matrix = calculate_matrix(obj)
%CALCULATE_MATRIX Summary of this function goes here
%   Detailed explanation goes here
    nspin=obj.spin_collection.getLength;
    L_matrix=0;   
    
    for kk=1:nspin
        spin=obj.spin_collection.spin_list{kk};
        if spin.dim>2
            L_kk=0;
            L_matrix=L_matrix+L_kk;
        elseif spin.dim==2
            L_kk=obj.gen_superoperator_single(spin,kk);
            
            L_matrix=sparse(L_matrix+L_kk);
            
        end
                
    end

end


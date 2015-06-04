function matrix_cells= linear_sequence_expm( mat,maxpower,power_step)
%LINEAR_SEQUENCE_EXPM 
    ncells=maxpower/power_step;
    dim=size(mat);
    if rem(ncells,1)==0
        matrix_cells=cell(ncells+1,1);
        matrix_cells{1,1}=eye(dim);
        core=mat^power_step;
        for n=2:(ncells+1)
             matrix_cells{n,1}= matrix_cells{n-1,1}*core;
        end
    else
        matrix_cells=0;
        disp('wrong steps of the powers');
    end

end

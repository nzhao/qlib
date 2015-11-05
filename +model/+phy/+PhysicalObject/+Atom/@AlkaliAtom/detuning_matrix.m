function dGdw= detuning_matrix(obj,J)
    gg=obj.dimG;
    if J==1.5
        ge=obj.dimE2;
    elseif J==0.5
        ge=obj.dimE1;
    else 
        disp('Error J')
    end
    gt=(ge+gg)^2;
    n2=ge^2+1:ge^2+ge*gg;
    n3=ge^2+ge*gg+1:ge^2+2*ge*gg;
    dGdw=zeros(gt,gt); 
    dGdw(n2,n2)=1j*eye(ge*gg);
    dGdw(n3,n3)=-dGdw(n2,n2);
end


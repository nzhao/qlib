function tV=electricDipoleInteraction(obj,J,magB)
    if J==0.5
        ge=obj.dimE1;
    elseif J==1.5;
        ge=obj.dimE2;
    else
        disp('error J');
    end
    
    tV=zeros(ge,obj.dimG);
    Ds=obj.happerMatrixCoupled(J,magB);
    for k=1:3 %sum over three Cartesian axes
        Omega=obj.beam.Omega;
        tV=tV-Ds(:,:,k)'*Omega(k);
    end

end
function Asge=coupledSpontaneousMatrix(obj,J,magB)
<<<<<<< HEAD
    I=obj.parameters.spin_I;
    S=obj.parameters.spin_S;
    gS=2*S+1;gI=2*I+1;gJ=2*J+1;gg=gI*gS;ge=gI*gJ;
    Asge=zeros(gg*gg,ge*ge); 
    Dj=obj.happerMatrixCoupled(J,magB);
    for j=1:3 %sum over three Cartesian axes 
    Asge=Asge+(gJ/3)*kron(conj(Dj(:,:,j)),Dj(:,:,j)); 
    end
end
=======
if J==1.5
    ge=obj.dimE2;
    ele=obj.e2Spin;
elseif J==0.5
    ge=obj.dimE1;
    ele=obj.e1Spin;
end
gg=obj.dimG;
gJ=ele.dim;
Asge=zeros(gg*gg,ge*ge); 
Dj=obj.happerMatrixCoupled(J,magB);
for j=1:3 %sum over three Cartesian axes 
Asge=Asge+(gJ/3)*kron(conj(Dj(:,:,j)),Dj(:,:,j)); 
end 
>>>>>>> master

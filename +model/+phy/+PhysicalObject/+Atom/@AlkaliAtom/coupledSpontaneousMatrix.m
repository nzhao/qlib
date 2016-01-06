function Asge=coupledSpontaneousMatrix(obj,J,magB)
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
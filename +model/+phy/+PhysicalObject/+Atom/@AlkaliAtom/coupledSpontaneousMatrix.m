function Asge=coupledSpontaneousMatrix(J,I,S,B)
gS=2*S+1;gI=2*I+1;gJ=2*J+1;gg=gI*gS;ge=gI*gJ;
Asge=zeros(gg*gg,ge*ge); 
Dj=happerMatrixCoupled(J,I,B);
for j=1:3 %sum over three Cartesian axes 
Asge=Asge+(gJ/3)*kron(conj(Dj(:,:,j)),Dj(:,:,j)); 
end 
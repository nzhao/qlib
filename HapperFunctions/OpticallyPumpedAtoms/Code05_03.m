%Code02_01 %constants, atomic properties
%Code03_01 %uncoupled spin matrices
%Code03_02 %energy basis states, unitary matrices
%Code03_06 %zero-field energies
%Code04_01 %projection operators
%Code05_02 %spherical projections in electronic space 
for j=1:3;
    mug(:,:,j)=Ug'*umug(:,:,j)*Ug;
    Ijg(:,:,j)=Ug'*aIjg(:,:,j)*Ug;
    Ije(:,:,j)=Ue'*aIje(:,:,j)*Ue;
    Sj(:,:,j)=Ug'*gSj(:,:,j)*Ug;
    Jj(:,:,j)=Ue'*gJj(:,:,j)*Ue;
    Dj(:,:,j)=Ug'*gDj(:,:,j)*Ue;
end
fg=round(-1+sqrt(1+4*(2*diag(Ug'*uIS*Ug)+I*(I+1)+S*(S+1))))/2;
fe=round(-1+sqrt(1+4*(2*diag(Ue'*uIJ*Ue)+I*(I+1)+J*(J+1))))/2;
mg=round(2*diag(Ijg(:,:,3)+Sj(:,:,3)))/2; Fzg=diag(mg);
me=round(2*diag(Ije(:,:,3)+Jj(:,:,3)))/2; Fze=diag(me);
x=kron(fg,ones(1,gg));fgl=x(:); %left f label
x=x'; fgr=x(:);%right f label
x=kron(mg,ones(1,gg)); mgl=x(:); %left m label
x=x'; mgr=x(:);%right m label
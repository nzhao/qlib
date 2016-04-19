%Code02_01 %constants, atomic properties
%Code03_01 %uncoupled spin matrices
for k=1:3;% uncoupled magnetic moment operators
    umug(:,:,k)=-LgS*muB*gSj(:,:,k)+(muI/(I+eps))*aIjg(:,:,k);
    umue(:,:,k)=-LgJ*muB*gJj(:,:,k)+(muI/(I+eps))*aIje(:,:,k);
end
uIS=matdot(aIjg,gSj);%uncoupled I.S
uIJ=matdot(aIje,gJj);%uncoupled I.J
B=input('Static magnetic field in Gauss, B = ');
uHg=Ag*uIS-umug(:,:,3)*B;%uncoupled Hamiltonian
[Ug,Eg]=eig(uHg);%unsorted eigenvectors and energies
[x,n]=sort(-diag(Eg));%sort energies in descending order
Hg=Eg(n,n); Eg=diag(Hg); Ug=Ug(:,n);%sorted Hg, Eg and Ug
uHe=Ae*uIJ - umue(:,:,3)*B;%Hamiltonian without quadrupole interaction
if J>1/2&I>1/2
    uHe = uHe+Be*(3*uIJ^2+1.5*uIJ-I*(I+1)*J*(J+1)*eye(ge))...
        /(2*I*(2*I-1)*J*(2*J-1));%add quadrupole interaction
end
[Ue,Ee]=eig(uHe);%unsorted eigenvectors and energies
[x,n]=sort(-diag(Ee));%sort energies in descending order
He=Ee(n,n); Ee=diag(He); Ue=Ue(:,n);%sorted He, Ee, and Ue
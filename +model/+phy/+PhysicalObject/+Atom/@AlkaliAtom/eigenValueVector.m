function [Eg,Ug,Ee,Ue] = eigenValueVector( obj, J, magB )
%EIGENVALUEVECTOR Summary of this function goes here
%   Detailed explanation goes here

    [Ug,Eg]=eig(obj.gsHamiltonian(magB));%unsorted eigenvectors and energies
    [~,n]=sort(-diag(Eg));%sort energies in descending order
    Hg=Eg(n,n); Eg=diag(Hg); Ug=Ug(:,n);%sorted Hg, Eg and Ug
    [Ue,Ee]=eig(obj.esHamiltonian(J,magB));%unsorted eigenvectors and energies
    [~,n]=sort(-diag(Ee));%sort energies in descending order
    He=Ee(n,n); Ee=diag(He); Ue=Ue(:,n);%sorted He, Ee, and Ue
end


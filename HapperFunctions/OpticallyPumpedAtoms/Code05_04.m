%Code02_01 %constants, atomic properties
%Code03_01 %uncoupled spin matrices
%Code03_02 %energy basis states, unitary matrices
%Code03_06 %zero-field energies
%Code04_01 %projection operators
%Code05_02 %spherical projections in electronic space 
%Code05_03 %matrices in energy basis, low field labels
Asge=zeros(gg*gg,ge*ge); 
for j=1:3 %sum over three Cartesian axes 
Asge=Asge+(gJ/3)*kron(conj(Dj(:,:,j)),Dj(:,:,j)); 
end 
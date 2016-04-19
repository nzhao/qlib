%Code02_01 %constants, atomic properties
%Code03_01 %uncoupled spin matrices
%Code03_02 %energy basis states, unitary matrices
%Code03_06 %zero-field energies
%Code04_01 %projection operators
mu=(1:gg)?*ones(1,gg); mu=mu(:); 
nu=ones(gg,1)*(1:gg); nu=nu(:); 
T=zeros(gg*gg,gg*gg); 
for j=1:gg*gg 
T(:,j)=mu(j)==nu & nu(j)==mu; 
end 
%Code02_01 %constants, atomic properties
%Code03_01 %uncoupled spin matrices
%Code03_02 %energy basis states, unitary matrices
%Code03_06 %zero-field energies
%Code04_01 %projection operators
%Code05_02 %spherical projections in electronic space
%Code05_03 %matrices in energy basis, low field labels
%Code05_04 %spontaneous emission matrices
%Code05_05 %light characteristics, interaction matrix
%Code05_06 %energy difference matrices
%Code05_07 %Optical Bloch Equations with uniform damping
%Code05_08 %OBE transient response
rhoinf=null(G);rhoinf=rhoinf/(rP*rhoinf); 
Nginf=rNg*rhoinf; Neinf=rNe*rhoinf; 
plot(th/te,real(Nginf)*ones(1,nt),'b-') 
plot(th/te,real(Neinf)*ones(1,nt),'r-.') 
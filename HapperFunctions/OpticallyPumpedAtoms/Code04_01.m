%Code02_01 %constants, atomic properties
%Code03_01 %uncoupled spin matrices
%Code03_02 %energy basis states, unitary matrices
%Code03_06 %zero-field energies
Pg=eye(gg); Pe=eye(ge);%projection operators 
cPe=Pe(:); rPe=cPe'; cPg=Pg(:); rPg=cPg(:)'; 
gt=(gg+ge)^2;%dimension of full Liouville space 
cNe=[cPe;zeros(gt-ge*ge,1)]; rNe=cNe'; LrNe=logical(rNe); 
cNg=[zeros(gt-gg*gg,1); cPg];rNg=cNg'; LrNg=logical(rNg); 
cP=cNe+cNg; rP=rNe+rNg; 
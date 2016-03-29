clear; clc
import model.phy.PhysicalObject.Atom.AlkaliAtom
rb=AlkaliAtom('87Rb');


magB=1e15;
gsHO=rb.disturbgsHamiltonian(magB);
gsDisturb=rb.gsHamiltonian(magB)-rb.disturbgsHamiltonian(magB);
[gsV,gsD]=eig(gsHO);
addEvalue=diag(gsV'*gsDisturb*gsV);
mendEValue=diag(gsD)+addEvalue;

[~,gsD1]=eig(rb.gsHamiltonian(magB));
eValue=diag(gsD1);

differ=mendEValue+eValue;




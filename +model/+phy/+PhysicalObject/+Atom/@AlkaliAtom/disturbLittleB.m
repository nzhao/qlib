clear; clc
import model.phy.PhysicalObject.Atom.AlkaliAtom
rb=AlkaliAtom('87Rb');

magB=1e-11;

disturbHamil=rb.disturbgsHamiltonian(magB);
gsHami=rb.gsHamiltonian(0.00);
[gsV, gsD]=eig(gsHami);
disturbMatrix=gsV'*disturbHamil*gsV;
[dgsV,dgsD]=eig(disturbMatrix);
mendEValue=diag(dgsD)+diag(gsD);%disturb situation

[gsV11,gsD11]=eig(rb.gsHamiltonian(magB));
eValue=diag(gsD11);

differ=mendEValue-eValue;




%    little magB
clear; clc
import model.phy.PhysicalObject.Atom.AlkaliAtom
rb=AlkaliAtom('87Rb');
disturbHamil=rb.disturbgsHamiltonian(magB);
gsHami=rb.gsHamiltonian(magB);
[gsV, gsD]=eig(gsHami);
disturbMatrix=gsV'*disturbHamil1*gsV;
[dgsV,dgsD]=eig(diturbMatrix);
mendEValue=diag(dgsD)+diag(gsD);

blist=0:0.0010:0.200;
vlist=zeros(8, length(blist));
for i=1:length(blist)
    disturbMatrix(i)=gsV'*disturbHamil1(blist(i))*gsV;
    vlist(:,i)=eig(rb.gsHamiltonian(blist(i)))+eig(disturbMatrix(i));
end
plot(blist, vlist')

%  huge magB

blist=0.5:0.0010:1;
vlist=zeros(8, length(blist));
for i=1:length(blist)
    disturbHamil(i)=rb.gsHamiltonian(blist(i))-rb.disturbgsHamiltonian(blist(i));
    vlist(:,i)=eig(rb.gsHamiltonian(blist(i)))+eig(gsV'*disturbHamil(i)*gsV);
end
plot(blist, vlist')


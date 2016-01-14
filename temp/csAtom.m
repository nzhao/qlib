clear; clc
import model.phy.PhysicalObject.Atom.AlkaliAtom

cs=AlkaliAtom('133Cs');

magB=0.0000;
gsHami=cs.gsHamiltonian(magB);
[gsV, gsD]=eig(gsHami);

gsValue=diag(gsD);
zeroField_gsValue=[gsValue(1), gsValue(end)];
h0coupled_representation=gsV'*gsHami*gsV;

magB1=0.0001;
gsHami1=cs.gsHamiltonian(magB1);
[gsV1, gsD1]=eig(gsHami1);
h1coupled_representation=gsV1'*gsHami1*gsV1;
idx=[1 4 2 5 3 7 6 8];
reOrder_h1=h1coupled_representation(idx,idx);

gsValue1=diag(gsD1);
diffF1=diff(gsValue1(1:3))/2/pi;
diffF2=diff(gsValue1(4:end))/2/pi;


blist=0:0.0010:1.0000;
vlist=zeros(16, length(blist));
for i=1:length(blist)
    vlist(:,i)=eig(cs.gsHamiltonian(blist(i)));
end
plot(blist, vlist')



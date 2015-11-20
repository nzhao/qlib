clear all
clc

import model.phy.SpinCollection.Strategy.From1Dchain
import model.phy.SpinCollection.Strategy.FromFile
import model.phy.SpinCollection.SpinCollection
import model.phy.SpinInteraction.DipolarInteraction
import model.phy.QuantumOperator.SpinOperator.Hamiltonian
import model.phy.QuantumOperator.MatrixStrategy.FromKronProd

nspin=20;
%spin_collection=SpinCollection(FromFile([INPUT_FILE_PATH, '+xyz/butaneProton.xyz']));
spin_collection=SpinCollection(From1Dchain(nspin, '13C'));
dip=DipolarInteraction(spin_collection);
strategy=FromKronProd();
hm=Hamiltonian(spin_collection, strategy);
hm.addInteraction(dip);
skp=hm.getMatrix;

disp('skp generated.');
% hm1=Hamiltonian(spin_collection);
% hm1.addInteraction(dip);
% mat=hm1.getMatrix;
% 
% delta=skp.full()-mat;
% norm(delta)

t=0.001;
x=zeros(2^nspin, 1);
x(2)=1;
% xt1=expv(-1i*t, mat, x);
xt2=expv(-1i*t, skp, x);

% norm(xt1-xt2)
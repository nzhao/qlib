import model.phy.PhysicalObject.Atom.AlkaliAtom

rb=AlkaliAtom('87Rb');

magB=0.0100; j=1.5;
gsHami=rb.gsHamiltonian(magB);
esHami=rb.esHamiltonian(j, magB);


thetaD=10.; phiD=8.0; eTheta=1.0; ePhi=0.0; Sl=1.0;
kVec=[thetaD, phiD]; pol=[eTheta, ePhi];
rb.setBeam( 'D1', kVec, pol, Sl)

tV=rb.electricDipoleInteraction(j, magB);clc


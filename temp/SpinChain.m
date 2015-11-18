import model.phy.SpinCollection.SpinCollection
import model.phy.SpinCollection.Strategy.From1Dchain
import model.phy.QuantumOperator.SpinOperator.Hamiltonian
import model.phy.SpinInteraction.SpinChainInteraction.OnSiteEnergy
import model.phy.SpinInteraction.SpinChainInteraction.XYInteraction

nspin=10; spin_type='1H';
xyParameter.interaction=ones(1, nspin-1);
onSiteParameter.interaction=ones(1, nspin);

sc=SpinCollection(From1Dchain(nspin, spin_type));
hm=Hamiltonian(sc);
hm.addInteraction(OnSiteEnergy(sc, onSiteParameter));
hm.addInteraction(XYInteraction(sc, xyParameter) );
hm.s
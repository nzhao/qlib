clear;clc;
%% FromSpinList 
spin_collection=model.phy.SpinCollection.SpinCollection();

slist=[model.phy.PhysicalObject.Spin('13C', [1,1,1]), ...
       model.phy.PhysicalObject.Spin('13C', [10,10,10]), ...
       model.phy.PhysicalObject.Spin('13C', [20,20,20])];
strategy = model.phy.SpinCollection.Strategy.FromSpinList(slist);

spin_collection.strategy=strategy;
spin_collection.generate();

%% SpinInteraction
para.B=1e-3;
hami=model.phy.QuantumOperator.Hamiltonian(spin_collection);
interaction1=model.phy.SpinInteraction.ZeemanInteraction(spin_collection, para);
interaction2=model.phy.SpinInteraction.DipolarInteraction(spin_collection, para);
hami.addInteraction(interaction1);
hami.addInteraction(interaction2);

hami.strategy=model.phy.QuantumOperator.MatrixStrategy.FromProductSpace();
hami.generate_matrix();
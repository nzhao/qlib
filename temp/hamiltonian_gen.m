clear;clc;
%% FromSpinList 
spin_collection=model.phy.SpinCollection.SpinCollection();

slist=[model.phy.Spin('13C', [1,1,1]), ...
       model.phy.Spin('13C', [10,10,10]), ...
       model.phy.Spin('13C', [20,20,20])];
strategy = model.phy.SpinCollection.Strategy.FromSpinList(slist);

spin_collection.strategy=strategy;
spin_collection.generate();

%% SpinInteraction
para.B=100.0;

iter=model.phy.SpinCollection.Iterator.SingleSpinIterator(spin_collection);
hami=model.phy.QuantumOperator.Hamiltonian(spin_collection);

interaction=model.phy.SpinInteraction.ZeemanInteraction(iter, para);
hami.addInteraction(interaction);


hami.strategy=model.phy.QuantumOperator.MatrixStrategy.FromProductSpace();
hami.generate_matrix();
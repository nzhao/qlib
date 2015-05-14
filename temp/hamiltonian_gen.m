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

strategy=model.phy.QuantumOperator.MatrixStrategy.FromProductSpace();
hami.strategy=strategy;
hami.generate_matrix();

lv=model.phy.QuantumOperator.Liouvillian(spin_collection);
lv.strategy=model.phy.QuantumOperator.MatrixStrategy.FromHamiltonianToLiouvillian(hami);
lv.generate_matrix();

%% DensityMatrix

denseMat=model.phy.QuantumOperator.DensityMatrix(spin_collection);
spin_order=model.phy.SpinInteraction.SpinOrder(spin_collection, [1], {[1,0; 0,0]});
denseMat.addSpinOrder(spin_order);

denseMat.strategy=strategy;
denseMat.generate_matrix();

%% Evolution
ker=model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution(lv);
dynamics=model.phy.Dynamics.QuantumDynamics(ker);
dynamics.set_initial_state(denseMat);
dynamics.set_time_sequence(1:10);
dynamics.evolve();
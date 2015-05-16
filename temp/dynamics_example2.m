clear;clc;
%% Package import
%physical objects
import model.phy.PhysicalObject.Spin
import model.phy.SpinCollection.SpinCollection

%quantum operators
import model.phy.QuantumOperator.Hamiltonian
import model.phy.QuantumOperator.Liouvillian
import model.phy.QuantumOperator.DensityMatrix
import model.phy.QuantumOperator.Observable
import model.phy.Dynamics.QuantumDynamics

%interactoins
import model.phy.SpinInteraction.ZeemanInteraction
import model.phy.SpinInteraction.DipolarInteraction
import model.phy.SpinInteraction.SpinInteraction
import model.phy.SpinInteraction.SpinOrder
import model.phy.SpinInteraction.GeneralSpinInteraction

%strategies
import model.phy.SpinCollection.Strategy.FromSpinList
import model.phy.QuantumOperator.MatrixStrategy.FromProductSpace
import model.phy.QuantumOperator.MatrixStrategy.FromHamiltonianToLiouvillian
import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution

%% FromSpinList 

spin_collection=SpinCollection();
spin_collection.spin_source = FromSpinList(...
    [Spin('1H', [1,1,0]),...
     Spin('1H', [0 0 0])]...
     );
spin_collection.generate();

%% SpinInteraction

para.B=1e-4*[0 0 1000.];
hami=Hamiltonian(spin_collection);
liou=Liouvillian(spin_collection);
liou.matrix_strategy=FromHamiltonianToLiouvillian(hami);

liou.addInteraction( ZeemanInteraction(spin_collection, para) );
liou.addInteraction( DipolarInteraction(spin_collection, para) );
liou.generate_matrix();

%% DensityMatrix

denseMat=DensityMatrix(spin_collection);
denseMat.addSpinOrder( SpinOrder(spin_collection, {[1,2]}, { {'sz', 'sz'} }) );
%denseMat.addSpinOrder( GeneralSpinInteraction(spin_collection, {[1,2]}, { {[1 0; 0 1], [0 0; 0 1]} }, {1.}) );
denseMat.generate_matrix();

%% Observable

obs1=Observable(spin_collection);
obs1.setName('s1x');
obs1.addInteraction( SpinInteraction(spin_collection, {1}, { {'sx'} }) );
obs1.generate_matrix();


obs2=Observable(spin_collection);
obs2.setName('s1z');
obs2.addInteraction( SpinInteraction(spin_collection, {1}, { {'sz'} }) );
obs2.generate_matrix();

%% Evolution

dynamics=QuantumDynamics( MatrixVectorEvolution(liou) );
dynamics.set_initial_state(denseMat);
dynamics.set_time_sequence(0:2e-6:10e-4);
dynamics.addObervable(obs1);
dynamics.addObervable(obs2);
dynamics.calculate_mean_values();

%% plot
dynamics.render.plot('s1x');
hold on;
dynamics.render.plot('s1z', 'b*-');
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
import model.phy.SpinCollection.Strategy.FromFile
import model.phy.QuantumOperator.MatrixStrategy.FromProductSpace
import model.phy.QuantumOperator.MatrixStrategy.FromHamiltonianToLiouvillian
import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution

%% FromSpinList 

spin_collection=SpinCollection();
spin_collection.spin_source = FromFile(...
    [INPUT_FILE_PATH, '+xyz/BenzeneProton.xyz']...
     );
spin_collection.generate();

%% SpinInteraction

para.B=1e-4*[0 0 100];
hami=Hamiltonian(spin_collection);
liou=Liouvillian(spin_collection);
liou.matrix_strategy=FromHamiltonianToLiouvillian(hami);

liou.addInteraction( ZeemanInteraction(spin_collection, para) );
liou.addInteraction( DipolarInteraction(spin_collection, para) );
liou.generate_matrix();

%% DensityMatrix

denseMat=DensityMatrix(spin_collection);
%denseMat.addSpinOrder( SpinOrder(spin_collection, {[1,2]}, { {'sz', 'sz'} }) );
%denseMat.addSpinOrder( GeneralSpinInteraction(spin_collection, {[1,2],}, { {[1 0; 0 0], [0.5 0; 0 0.5]}, }, {1.0,}) );
denseMat.addSpinOrder( GeneralSpinInteraction(spin_collection, {1,}, { {[1 0; 0 0]}, }, {1.0,}) );
denseMat.generate_matrix();

%% Observable

obs1=Observable(spin_collection);
obs1.setName('s1z');
obs1.addInteraction( SpinInteraction(spin_collection, {1}, { {'sz'} }) );
obs1.generate_matrix();


obs2=Observable(spin_collection);
obs2.setName('s2z');
obs2.addInteraction( SpinInteraction(spin_collection, {2}, { {'sz'} }) );
obs2.generate_matrix();

%% Evolution

dynamics=QuantumDynamics( MatrixVectorEvolution(liou) );
dynamics.set_initial_state(denseMat);
dynamics.set_time_sequence(0:20e-6:5e-3);
dynamics.addObervable(obs1);
dynamics.addObervable(obs2);
dynamics.calculate_mean_values();

%% plot
dynamics.render.plot('s1z');
hold on;
dynamics.render.plot('s2z', 'b*-');
clear;clc;
%% Package import
import model.phy.PhysicalObject.Spin
import model.phy.SpinCollection.SpinCollection

import model.phy.QuantumOperator.Hamiltonian
import model.phy.QuantumOperator.Liouvillian
import model.phy.QuantumOperator.DensityMatrix
import model.phy.QuantumOperator.Observable
import model.phy.Dynamics.QuantumDynamics

import model.phy.SpinInteraction.ZeemanInteraction
import model.phy.SpinInteraction.DipolarInteraction
import model.phy.SpinInteraction.SpinInteraction
import model.phy.SpinInteraction.SpinOrder

import model.phy.SpinCollection.Strategy.FromFile
import model.phy.QuantumOperator.MatrixStrategy.FromProductSpace
import model.phy.QuantumOperator.MatrixStrategy.FromHamiltonianToLiouvillian
import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution

%% FromSpinList 

spin_collection=SpinCollection();
spin_collection.spin_source = FromFile([INPUT_FILE_PATH, '+xyz/BenzeneProton.xyz']);
spin_collection.generate();

%% SpinInteraction

para.B=1e-3;
hami=Hamiltonian(spin_collection);
liou=Liouvillian(spin_collection);
liou.matrix_strategy=FromHamiltonianToLiouvillian(hami);

liou.addInteraction( ZeemanInteraction(spin_collection, para) );
liou.addInteraction( DipolarInteraction(spin_collection, para) );
liou.generate_matrix();

%% DensityMatrix

denseMat=DensityMatrix(spin_collection);
denseMat.addSpinOrder( SpinOrder(spin_collection, {[1, 2], [2,3]}, { {'sz', 'sx'}, {'sx', 'sy'} }, {0.5, 0.5}) );
%denseMat.addSpinOrder( SpinOrder(spin_collection, {1}, { {'sz'} }) );
denseMat.generate_matrix();

%% Observable

obs1=Observable(spin_collection);
obs1.setName('s1z');
obs1.addInteraction( SpinInteraction(spin_collection, {1}, { {'sz'} }) );
obs1.generate_matrix();

obs2=Observable(spin_collection);
obs2.addInteraction( SpinInteraction(spin_collection, {2}, { {'sx'} }) );
obs2.setName('s2x');
obs2.generate_matrix();

%% Evolution

dynamics=QuantumDynamics( MatrixVectorEvolution(liou) );
dynamics.set_initial_state(denseMat);
dynamics.set_time_sequence(0:1e-5:1e-4);
dynamics.addObervable(obs1);
dynamics.addObervable(obs2);
dynamics.calculate_mean_values();

%% plot
plt=dynamics.render.plot('s1z', @real);

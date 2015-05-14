clear;clc;
%% Package import
import model.phy.PhysicalObject.Spin
import model.phy.SpinCollection.SpinCollection

import model.phy.QuantumOperator.Hamiltonian
import model.phy.QuantumOperator.Liouvillian
import model.phy.QuantumOperator.DensityMatrix
import model.phy.Dynamics.QuantumDynamics

import model.phy.SpinInteraction.ZeemanInteraction
import model.phy.SpinInteraction.DipolarInteraction
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
denseMat.addSpinOrder( SpinOrder(spin_collection, 1, {[1,0; 0,0]}) );
denseMat.generate_matrix();

%% Evolution

dynamics=QuantumDynamics( MatrixVectorEvolution(liou) );
dynamics.set_initial_state(denseMat);
dynamics.set_time_sequence(0:1e-5:1e-4);
dynamics.evolve();
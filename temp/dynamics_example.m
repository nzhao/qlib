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

import model.phy.SpinCollection.Strategy.FromSpinList
import model.phy.QuantumOperator.MatrixStrategy.FromProductSpace
import model.phy.QuantumOperator.MatrixStrategy.FromHamiltonianToLiouvillian
import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution

%% FromSpinList 

spin_collection=SpinCollection();

spin_collection.strategy = FromSpinList(...
    [Spin('13C', [1,1,1]),...
     Spin('13C', [10,10,10]),...
     Spin('13C', [20,20,20])...
     ]);
spin_collection.generate();

%% SpinInteraction

para.B=1e-3;
hami=Hamiltonian(spin_collection);
hami.strategy= FromProductSpace();

lv=Liouvillian(spin_collection);
lv.strategy=FromHamiltonianToLiouvillian(hami);

interaction1=ZeemanInteraction(spin_collection, para);
interaction2=DipolarInteraction(spin_collection, para);
lv.addInteraction(interaction1);
lv.addInteraction(interaction2);

lv.generate_matrix();

%% DensityMatrix

denseMat=DensityMatrix(spin_collection);
denseMat.strategy=FromProductSpace();

spin_order=SpinOrder(spin_collection, 1, {[1,0; 0,0]});
denseMat.addSpinOrder(spin_order);

denseMat.generate_matrix();

%% Evolution

dynamics=QuantumDynamics( MatrixVectorEvolution(lv) );
dynamics.set_initial_state(denseMat);
dynamics.set_time_sequence(1:10);
dynamics.evolve();
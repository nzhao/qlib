clear;clc;
%% Package import
import model.phy.PhysicalObject.Spin
import model.phy.SpinCollection.SpinCollection

import model.phy.QuantumOperator.SpinOperator.Hamiltonian
import model.phy.QuantumOperator.SpinOperator.Liouvillian
import model.phy.QuantumOperator.SpinOperator.DensityMatrix
import model.phy.Dynamics.QuantumDynamics

import model.phy.SpinInteraction.ZeemanInteraction
import model.phy.SpinInteraction.DipolarInteraction
import model.phy.SpinInteraction.SpinOrder

import model.phy.SpinCollection.Strategy.FromSpinList
import model.phy.QuantumOperator.MatrixStrategy.FromProductSpace
import model.phy.QuantumOperator.MatrixStrategy.FromProductSpaceProjection
import model.phy.QuantumOperator.MatrixStrategy.FromHamiltonianToLiouvillian
import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution

%% FromSpinList 

spin_collection=SpinCollection();

spin_collection.spin_source = FromSpinList(...
    [Spin('13C', [1,1,1]),...
     Spin('13C', [10,10,10]),...
     Spin('13C', [20,20,20])...
     ]);
spin_collection.generate();

%% SpinInteraction

para.B=1e-4*[0 0 0];
hami=Hamiltonian(spin_collection );

hami.addInteraction( ZeemanInteraction(spin_collection, para) );
hami.addInteraction( DipolarInteraction(spin_collection, para) );

hami.generate_matrix();
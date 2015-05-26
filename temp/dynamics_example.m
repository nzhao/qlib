clear;clc;
%% Package import
import model.phy.PhysicalObject.Spin
import model.phy.SpinCollection.SpinCollection

import model.phy.QuantumOperator.SpinOperator.Hamiltonian
import model.phy.QuantumOperator.SpinOperator.DensityMatrix
import model.phy.Dynamics.QuantumDynamics

import model.phy.SpinInteraction.ZeemanInteraction
import model.phy.SpinInteraction.DipolarInteractionSecular

import model.phy.SpinCollection.Strategy.FromSpinList
import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution

%% FromSpinList 
s1=Spin('13C', [9,11,10]);
s2=Spin('13C', [10,10,10]);
s3=Spin('13C', [11,11,11]);

spin_collection=SpinCollection();
spin_collection.spin_source = FromSpinList([s1, s2, s3]);
spin_collection.generate();

%% SpinInteraction

para.B=1e-4*[0 0 1];
para.rotation_frequency=para.B*s1.gamma;

hami=Hamiltonian(spin_collection );
hami.addInteraction( ZeemanInteraction(spin_collection, para) );
hami.addInteraction( DipolarInteractionSecular(spin_collection, para) );

hami1=hami.project_operator(1, 1);
hami2=hami.project_operator(1, 2);

lv=hami1.flat_sharp_circleC(hami2);

%% state

denseMat1=DensityMatrix(spin_collection, {'1.0 * mat([1 0; 0 1])_1'});
denseMat=denseMat1.project_operator(1, 1);

%% obs
obs1=Observable(spin_collection, 'coherence', {'1.0 * p(1)_1'});
obs=obs1.project_operator(1, 1);

%% dynamics
dynamics=QuantumDynamics( MatrixVectorEvolution(lv) );
dynamics.set_initial_state(denseMat);
dynamics.set_time_sequence(0:50e-6:100e-3);
dynamics.addObervable(obs);
dynamics.calculate_mean_values();


%%
figure();
dynamics.render.plot('coherence_1_1', @abs);
figure();
dynamics.render.fft('coherence_1_1', @abs);
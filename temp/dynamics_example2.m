clear;clc;
%% Package import
%physical objects
import model.phy.SpinCollection.SpinCollection

%quantum operators
import model.phy.QuantumOperator.SpinOperator.Hamiltonian
import model.phy.QuantumOperator.SpinOperator.DensityMatrix
import model.phy.QuantumOperator.SpinOperator.Observable
import model.phy.Dynamics.QuantumDynamics

%interactoins
import model.phy.SpinInteraction.ZeemanInteraction
import model.phy.SpinInteraction.DipolarInteraction

%strategies
import model.phy.SpinCollection.Strategy.FromFile
import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution

%% FromSpinList 

spin_collection=SpinCollection();
spin_collection.spin_source = FromFile(...
    [INPUT_FILE_PATH, '+xyz/BenzeneProton.xyz']...
     );
spin_collection.generate();

%% SpinInteraction

para.B=1e-4*[0 0 100];
para.rotation_frequency=para.B*spin_collection.spin_list{1}.gamma;

hami=Hamiltonian(spin_collection);
hami.addInteraction( ZeemanInteraction(spin_collection, para) );
hami.addInteraction( DipolarInteractionSecular(spin_collection, para) );

liou=hami.circleC();

%% DensityMatrix

denseMat=DensityMatrix(spin_collection, {'1.0 * p(1)_1 * p(2)_2 * p(2)_3 * p(2)_4 * p(2)_5 * p(2)_6'});

%% Observable

obs1=Observable(spin_collection, 'sz1', {'1.0 * sz_1'});
obs2=Observable(spin_collection, 'sz2', {'1.0 * sz_2'});
obs3=Observable(spin_collection, 'sz3', {'1.0 * sz_3'});
obs4=Observable(spin_collection, 'sz4', {'1.0 * sz_4'});
obs5=Observable(spin_collection, 'sz5', {'1.0 * sz_5'});
obs6=Observable(spin_collection, 'sz6', {'1.0 * sz_6'});

%% Evolution

dynamics=QuantumDynamics( MatrixVectorEvolution(liou) );
dynamics.set_initial_state(denseMat);
dynamics.set_time_sequence(0:20e-6:100e-3);
dynamics.addObervable([obs1, obs2, obs3, obs4, obs5, obs6]);
dynamics.calculate_mean_values();

%% plot
figure();
hold on;
dynamics.render.plot('sz1', @real);
dynamics.render.plot('sz2', 'b*-', @real);
dynamics.render.plot('sz3', 'gx-', @real);

figure();
hold on;
dynamics.render.plot('sz4', @real);
dynamics.render.plot('sz5', 'b*-', @real);
dynamics.render.plot('sz6', 'gx-', @real);
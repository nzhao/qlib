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
hami=Hamiltonian(spin_collection);
hami.addInteraction( ZeemanInteraction(spin_collection, para) );
hami.addInteraction( DipolarInteraction(spin_collection, para) );

liou=hami.circleC();

%% DensityMatrix

denseMat=DensityMatrix(spin_collection, {[1,2], }, { {'p(1)', 'p(2)'}, });
denseMat=DensityMatrix(spin_collection, 'sx_1 * sz_2');

%% Observable

obs1=Observable('s1z', spin_collection, {1}, { {'sz'} });
obs2=Observable('s2z', spin_collection, {2}, { {'sz'} });

%% Evolution

dynamics=QuantumDynamics( MatrixVectorEvolution(liou) );
dynamics.set_initial_state(denseMat);
dynamics.set_time_sequence(0:20e-6:1e-4);
dynamics.addObervable([obs1, obs2]);
dynamics.calculate_mean_values();

%% plot
hold on;
dynamics.render.plot('s1z', @real);
dynamics.render.plot('s2z', 'b*-', @real);
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
import model.phy.SpinInteraction.RotatingFrameInteraction
import model.phy.SpinInteraction.DipolarInteractionSecular

%strategies
import model.phy.SpinCollection.Strategy.FromFile
import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution

%% FromSpinList 

spin_collection=SpinCollection();
spin_collection.spin_source = FromFile(...
    [INPUT_FILE_PATH, '+xyz/BenzeneProtonZPlane.xyz']...
     );
spin_collection.generate();

%% SpinInteraction
Condition=LabCondition.getCondition;
Condition.setValue('magnetic_field', 1e-4*100*[1 1 1]);
para.B=1e-4*[0 0 100];
% para.rotation_frequency=para.B*spin_collection.spin_list{1}.gamma;

hami=Hamiltonian(spin_collection);
hami.addInteraction( ZeemanInteraction(spin_collection) );
% hami.addInteraction( RotatingFrameInteraction(spin_collection, para.B(3)*spin_collection.spin_list{1}.gamma) );
hami.addInteraction( DipolarInteractionSecular(spin_collection) );

liou=hami.circleC();
disp('liou generated');
%% DensityMatrix

denseMat=DensityMatrix(spin_collection, {'1.0 * p(2)_1 * p(1)_2 * p(1)_3 * p(1)_4 * p(1)_5 * p(1)_6'});

%% Observable

obs1=Observable(spin_collection, 'sz1', {'1.0 * sz_1'});

%% Evolution

dynamics=QuantumDynamics( MatrixVectorEvolution(liou) );
dynamics.set_initial_state(denseMat);
dynamics.set_time_sequence(0:20e-6:20e-3);
dynamics.addObervable([obs1]);
dynamics.calculate_mean_values();

%% plot
para.rm_average=1;
figure();
hold on;
dynamics.render.fft('sz1', @abs, para);

figure();
hold on;
dynamics.render.plot('sz1', @abs);
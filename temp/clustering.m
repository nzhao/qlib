clear;clc;
%% Package import
%physical condition and objects
import model.phy.LabCondition
import model.phy.PhysicalObject.NV
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
import model.phy.SpinCollection.Strategy.FromSpinList
import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution

import model.phy.SpinCollection.Iterator.ClusterIterator
import model.phy.SpinCollection.Iterator.ClusterIteratorGen.CCE_Clustering

import model.phy.SpinApproximation.SpinSecularApproximation
%% Condition

Condition=LabCondition.getCondition;
Condition.setValue('magnetic_field', 1e-4*100*[1 1 1]);


%% Generate Cluster using CCE clustering
%spin_coord_file_path='./+controller/+input/';
cluster=SpinCollection( FromFile([INPUT_FILE_PATH, '+xyz/RoyCoord.xyz']) );

clu_para.cutoff=8;
clu_para.max_order=4;
cce=CCE_Clustering(cluster, clu_para);

all_clusters=ClusterIterator(cluster,cce);

%% Generate NV center and transformer
NVcenter=NV();

%%

tic

NVe={NVcenter.espin};
bath_cluster=all_clusters.getItem(8600);
cluster=SpinCollection( FromSpinList([NVe, bath_cluster]) );

hami_cluster=Hamiltonian(cluster);
hami_cluster.addInteraction( ZeemanInteraction(cluster) );
hami_cluster.addInteraction( DipolarInteraction(cluster) );

hami_cluster.transform2selfEigenBases();
hami1=hami_cluster.project_operator(1, 1);
hami2=hami_cluster.project_operator(1, 2);
hami1.remove_identity();
hami2.remove_identity();


hami1.apply_approximation( SpinSecularApproximation(hami1.spin_collection) );
hami2.apply_approximation( SpinSecularApproximation(hami2.spin_collection) );

lv=hami1.flat_sharp_circleC(hami2);

%% state

denseMat1=DensityMatrix(cluster, {'1.0 * p(1)_1'});
denseMat=denseMat1.project_operator(1, 1);

%% obs
obs1=Observable(cluster, 'coherence', {'1.0 * p(1)_1'});
obs=obs1.project_operator(1, 1);

%% dynamics
dynamics=QuantumDynamics( MatrixVectorEvolution(lv) );
dynamics.set_initial_state(denseMat);
dynamics.set_time_sequence(0:10e-6:2e-3);
dynamics.addObervable(obs);
dynamics.calculate_mean_values();

toc
%%
figure();hold on;
dynamics.render.plot('coherence_1_1', @real);
dynamics.render.plot('coherence_1_1', @imag, 'b.-');
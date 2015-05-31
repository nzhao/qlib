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
import model.phy.SpinInteraction.DipolarInteractionSecular

%strategies
import model.phy.SpinCollection.Strategy.FromFile
import model.phy.SpinCollection.Strategy.FromSpinList
import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution

import model.phy.SpinCollection.Iterator.ClusterIterator
import model.phy.SpinCollection.Iterator.ClusterIteratorGen.CCE_Clustering

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
NVe={NVcenter.espin};
bath_cluster=all_clusters.getItem(600);
cluster=SpinCollection( FromSpinList([NVe, bath_cluster]) );

hami_cluster=Hamiltonian(cluster);
hami_cluster.addInteraction( ZeemanInteraction(cluster) );
hami_cluster.addInteraction( DipolarInteractionSecular(cluster) );

hami_cluster.transform_SelfEigenBases();
hami1=hami_cluster.project_operator(1, 1);
hami2=hami_cluster.project_operator(1, 2);

clear;clc;
%% Package import
%physical objects

import model.phy.SpinCollection.SpinCollection
%import model.phy.SpinCollection.SpinCollection.Iterator.ClusterIteratorGen.AbstractClusterIteratorGen
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
import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution


import model.phy.SpinCollection.Iterator.ClusterIterator
import model.phy.SpinCollection.Iterator.ClusterIteratorGen.CCE_Clustering

import model.phy.PhysicalObject.NV
%% FromSpinList 
tic

%spin_coord_file_path='./+controller/+input/';
cluster=SpinCollection();
cluster.spin_source = FromFile(...
    [INPUT_FILE_PATH, '+xyz/RoyCoord.xyz']...
     );
cluster.generate();
%% Generate Cluster using CCE clustering
clu_para.cutoff=8;
clu_para.max_order=4;
cce=CCE_Clustering(cluster, clu_para);

all_clusters=ClusterIterator(cluster,cce);

NVcenter=NV();
NVe={NVcenter.espin};
bath_cluster=all_clusters.currentItem();

cluster=SpinCollection();
cluster.spin_source = FromSpinList([NVe, bath_cluster]);
cluster.generate();
toc


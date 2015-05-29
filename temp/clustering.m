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
%% Generate Cluster using CCE clustering
tic

%spin_coord_file_path='./+controller/+input/';
cluster=SpinCollection();
cluster.spin_source = FromFile(...
    [INPUT_FILE_PATH, '+xyz/RoyCoord.xyz']...
     );
cluster.generate();

clu_para.cutoff=8;
clu_para.max_order=4;
cce=CCE_Clustering(cluster, clu_para);

all_clusters=ClusterIterator(cluster,cce);

%% Generate NV center and transformer
NVcenter=NV();
NVe={NVcenter.espin};

cluster_NVe=SpinCollection();
cluster_NVe.spin_source = FromSpinList(NVe);
cluster_NVe.generate();

para.B=1e-4*100*[1 1 1];
% para.rotation_frequency=para.B*cluster_NVe.spin_list{1}.gamma;
hami_NVe=Hamiltonian(cluster_NVe);
hami_NVe.addInteraction( ZeemanInteraction(cluster_NVe, para) );
hami_NVe_mat=hami_NVe.getMatrix();
[eigenvec,eigenval]=eig(full(hami_NVe_mat));
ts_mat=mat2str(eigenvec);

% ts=model.phy.QuantumOperator.SpinOperator.TransformOperator(cluster_NVe,{['1.0 * mat(' ts_mat ')_1']});%' num2str(eigenvec) '
% hami_NVe_mat2=hami_NVe.transform(ts);

% bath_cluster=all_clusters.currentItem();
bath_cluster=all_clusters.getItem(600);
cluster=SpinCollection();
cluster.spin_source = FromSpinList([NVe, bath_cluster]);
cluster.generate();
hami_cluster=Hamiltonian(cluster);
hami_cluster.addInteraction( ZeemanInteraction(cluster, para) );
hami_cluster.addInteraction( DipolarInteractionSecular(cluster, para) );

ts=model.phy.QuantumOperator.SpinOperator.TransformOperator(cluster,{['1.0 * mat(' ts_mat ')_1']});%' num2str(eigenvec) '
hami_trans=hami_cluster.transform(ts);
toc


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


import model.phy.SpinCollection.Iterator.ClusterIteratorGen.CCE_Clustering
%% FromSpinList 
tic

%spin_coord_file_path='./+controller/+input/';
spin_collection=SpinCollection();
spin_collection.spin_source = FromFile(...
    [INPUT_FILE_PATH, '+xyz/RoyCoord.xyz']...
     );
spin_collection.generate();
%% Generate Cluster using CCE clustering
clu_para.cutoff=8;
clu_para.max_order=4;
cluster_collection=CCE_Clustering(spin_collection,clu_para);

toc


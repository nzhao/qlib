% clear;clc
% if 0

cd /Users/ylp/Documents/code/qlib;
% cd D:\AcademicLife\code\qlib
addpath(genpath('./'));
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
import model.phy.Dynamics.EvolutionKernel.DensityMatrixEvolution

import model.phy.SpinCollection.Iterator.ClusterIterator
import model.phy.SpinCollection.Iterator.ClusterIteratorGen.CCE_Clustering

import model.phy.SpinApproximation.SpinSecularApproximation
%% Condition

Condition=LabCondition.getCondition;
Condition.setValue('magnetic_field', 1e-4*100*[1 1 1]);

% end
%% Generate Cluster using CCE clustering
spin_coord_file_path='./+controller/+input/';
cluster=SpinCollection( FromFile([spin_coord_file_path, '+xyz/hBNLayer.xyz']) );
para=cell(1,3);
namelist=[{'10B'},{'11B'},{'15N'}];
for n=1:3
    para{n}.name=namelist{n};
    para{n}.ZFS=500;
    para{n}.eta=0.01;
    para{n}.principle_axis=[1,1,1];
end
cluster.set_spin(para);%
% cluster=SpinCollection( FromFile([INPUT_FILE_PATH, '+xyz/RoyCoord.xyz']) );

clu_para.cutoff=8;
clu_para.max_order=2;
cce=CCE_Clustering(cluster, clu_para);

all_clusters=ClusterIterator(cluster,cce);

% if 0
%% Generate NV center and transformer
tic

NVcenter=NV();

NVe={NVcenter.espin};
bath_cluster=all_clusters.getItem(86);
cluster=SpinCollection( FromSpinList([NVe, bath_cluster]) );


hami_cluster=Hamiltonian(cluster);
hami_cluster.addInteraction( ZeemanInteraction(cluster) );
% hami_cluster.addInteraction( DipolarInteraction(cluster) );


% hami_cluster.transform2selfEigenBases();
ts=model.phy.QuantumOperator.SpinOperator.TransformOperator(cluster,{'1.0 * eigenVectors()_1'});
hami_cluster.transform(ts);

% hami1=hami_cluster.project_operator(1, 1);
% hami2=hami_cluster.project_operator(1, 2);
% hami1.remove_identity();
% hami2.remove_identity();
% 
% 
% hami1.apply_approximation( SpinSecularApproximation(hami1.spin_collection) );
% hami2.apply_approximation( SpinSecularApproximation(hami2.spin_collection) );
% 
% lv=hami1.flat_sharp_circleC(hami2);
% end
%% state
    denseMat=DensityMatrix(SpinCollection( FromSpinList(bath_cluster)));
    denseMat.getMatrix;
% denseMat1=DensityMatrix(cluster, '1.0 * p(1)_1');
% denseMat=denseMat1.project_operator(1, 1);

%% obs
obs1=Observable(cluster, 'coherence', '1.0 * p(1)_1');
obs=obs1.project_operator(1, 1);

%% dynamics
coh_para.state1=1;
coh_para.state2=2;
coh_para.npulse=1;

tmax=3*10^(-3);
ntime=401;
dt=tmax/(ntime-1);
timelist=0:dt:tmax;

% dynamics=QuantumDynamics( MatrixVectorEvolution(lv) );
dynamics=QuantumDynamics( ECCEMatrixEvolution(hami_cluster,coh_para) ); 
dynamics.set_initial_state(denseMat);
dynamics.set_time_sequence(0:10e-6:2e-3);
dynamics.addObervable(obs);
dynamics.calculate_mean_values();

toc
%%
figure();hold on;
dynamics.render.plot('coherence_1_1', @real);
dynamics.render.plot('coherence_1_1', @imag, 'b.-');
% end
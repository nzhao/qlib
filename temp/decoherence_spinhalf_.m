clear all;clc;
%% Package import
cd /Users/ylp/Documents/code/qlib

%physical objects
import model.phy.LabCondition
import model.phy.PhysicalObject.Spin
import model.phy.SpinCollection.SpinCollection

%quantum operators
import model.phy.QuantumOperator.SpinOperator.Hamiltonian
import model.phy.QuantumOperator.SpinOperator.DecoherenceSuperOperator
import model.phy.QuantumOperator.SpinOperator.DensityMatrix
import model.phy.QuantumOperator.SpinOperator.Observable

import model.phy.Dynamics.QuantumDynamics

%interactoins
import model.phy.SpinInteraction.ZeemanInteraction
import model.phy.SpinInteraction.DipolarInteraction
import model.phy.SpinApproximation.SpinSecularApproximation
%strategies
import model.phy.SpinCollection.Strategy.FromSpinList
import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution


Condition=LabCondition.getCondition;
Condition.setValue('magnetic_field', 1e-4*[0 0 1]);
Condition.setValue('temperature',0);

%% Hamiltonian and Liouvillian of the system
Se=Spin('E', [0,0,0]);
Sn=Spin('13C', [10,0,0]);
spin_collection=SpinCollection();
spin_collection.spin_source = FromSpinList([Se, Sn]);
spin_collection.generate();
spin_collection.set_spin();

hami=Hamiltonian(spin_collection);
hami.addInteraction( ZeemanInteraction(spin_collection) );
% hami.addInteraction( DipolarInteraction(spin_collection) );

L_h=hami.circleC();
L_h_mat=L_h.getMatrix;
%% Decoherence operator in Liouville space


nspin=length(spin_collection.spin_list);

GammaE_vertical=2*pi*2*10^4;
GammaE_parallel=0;
GammaN_vertical=0;%2*pi*10;
GammaN_parallel=0;%2*pi*20;


Gamma_vertical_list=[GammaE_vertical,GammaN_vertical];
Gamma_parallel_list=[GammaE_parallel,GammaN_parallel];
decay_rate_list.Gamma_vertical_list=Gamma_vertical_list;
decay_rate_list.Gamma_parallel_list=Gamma_parallel_list;

% decay_rate_list.Gamma_vertical_list=GammaE_vertical;
% decay_rate_list.Gamma_parallel_list=GammaE_parallel;
L_decay=DecoherenceSuperOperator(spin_collection,decay_rate_list);
L_decay_mat=L_decay.getMatrix;

L_tot=-1i*L_h_mat+L_decay_mat;

%measurement superoperator
q1=0.36;q0=0.64;

dim_n=Sn.dim;
R_halfPi=kron([1,1;-1,1]/sqrt(2),speye(dim_n));% rotation around the y axis with angle -pi/2 in the Hilbert space
L_halfPi=kron(R_halfPi,R_halfPi);% superoperator of the rotation around the y axis with angle -pi/2 in the Liouville space

%% DensityMatrix

denseMat=DensityMatrix(spin_collection, '1.0 * p(2)_1 * p(1)_2 ');
rho_vector0=L_halfPi*denseMat.getVector;% a pi/2 pulse is applied to transfer the state from |0> to (|0> + |1>)/sqrt(2)
%% Observable
obs_z=Observable(spin_collection, 'sz1', '1.0 * sz_1');
obs_x=Observable(spin_collection, 'sx1', '1.0 * sx_1');
obs_vecZ=obs_z.getVector;
obs_vecX=obs_x.getVector;
tstep=5e-8;
timelist=0:tstep:1e-4;
ntime=length(timelist);

sz_val=zeros(1,ntime);
sx_val=zeros(1,ntime);
nomal_factor_z=obs_vecZ'*rho_vector0;
nomal_factor_x=obs_vecX'*rho_vector0;

sz_val(1)=0;
sx_val(1)=1;
for kk=2:ntime
    t=timelist(kk);
    rho_vector=rho_vector0;
    rho_vector=expm(L_tot*t)*rho_vector;
    sz_val(1,kk)=obs_vecZ'*rho_vector;
    sx_val(1,kk)=obs_vecX'*rho_vector/nomal_factor_x;
end



figure();
plot(timelist,real(sz_val),'-ro')
figure();
plot(timelist,real(sx_val),'-b*')
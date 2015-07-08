%% Evolution of Dipolar Coupled Spin System
% This page demonstrates the calculation of quantum evolution of dipolar
% coupled spin system using 'DipolarCoupledSpinEvolution' class.

%% The Class
% Using the following command to import the _DipolarCoupledSpinEvolution_.
clear all; clc;
import model.phy.Solution.DipolarCoupledSpinEvolution

%%
% See  <matlab:doc('model.phy.Solution.DipolarCoupledSpinEvolution') doc> or <matlab:edit('model.phy.Solution.DipolarCoupledSpinEvolution') code> for more details.


%% Create a Solution From a XML file
xml_file='DipolarSpinDynamicsBenzene.xml';
sol=DipolarCoupledSpinEvolution(xml_file);

%% 
% The _xml_ file should contain the following parameters needed by the
% solution: 
%
% <html>
% <table border=1>
% <tr><td> Name</td>        <td>Variable</td>                                           <td>Tag</td></tr>
% <tr><td> SpinSource </td> <td>parameters.SpinCollectionStrategy</td>                  <td>'SpinCollection' > 'Source'</td></td></tr>
% <tr><td> InputFile  </td> <td>parameters.InputFile </td>                              <td>'SpinCollection' > 'FileName'</td></tr>
% <tr><td> B field    </td> <td>parameters.MagneticField </td>                          <td>'Condition'      > 'MagneticField'</td></tr>
% <tr><td> Approx.    </td> <td>parameters.IsSecularApproximation</td>                  <td>'Interaction'    > 'IsSecular'</td></tr>
% <tr><td> Init. St.  </td> <td>parameters.InitialState</td>                            <td>'InitialState'   > 'DensityMatrix'</td></tr>
% <tr><td> No. Obs.   </td> <td>parameters.ObservableNumber                             <td>'Observable'     > 'ObservableNumber'</td></tr>
% <tr><td> Obs. Name  </td> <td>parameters.ObservableName     [* ObservableNumber]</td> <td>'Observable'     > 'ObservableName1...N'</td></tr>
% <tr><td> Obs. Str.  </td> <td>parameters.ObservableString   [* ObservableNumber]</td> <td>'Observable'     > 'ObservableString1...N'</td></tr>
% <tr><td> Time List  </td> <td>parameters.TimeList</td>                                <td>'Dynamics'       > 'TimeList'</td></tr>
% </table>
% </html>
%
%%
% In the following, we perform the calculation step-by-step to demonstrate
% the usage of every methods of the _DipolarCoupledSpinEvolution_ class.

%% Set LabCondition
% This command set magnetic field according to the parameter defined in the
% xml file. 
sol.SetCondition();

%%
% The class <matlab:doc('model.phy.LabCondition'), _LabCondition_>
% is a singleton pattern. To look up the content of the _LabCondition_. Use
% the following command to look up the content.
import model.phy.LabCondition
condition=LabCondition.getCondition();
condition.list

%% Set SpinCollection
% Use the following command to create/return a spin list, according to the
% parameters defined in the xml file.
spin_collection=sol.GetSpinList();
%%
% There may generate some encoding warnings, which usually can be ignored.
% See <matlab:doc('model.phy.SpinCollection.SpinCollection') SpinCollection>.

%% Get Hamiltonian and Liouvillian
% Use the following command to generate Hamiltonian and Liouvillian
[hamiltonian, liouvillian]=sol.GetHamiltonianLiouvillian(spin_collection);
size(hamiltonian.matrix)
%%
% See <matlab:doc('model.phy.QuantumOperator.SpinOperator.Hamiltonian') _Hamiltonian_>.

%% Set Initial State
% Use the following command to set initial state
density_matrix = sol.GetDensityMatrix(spin_collection);
size(density_matrix)
%%
% See <matlab:doc('model.phy.QuantumOperator.SpinOperator.DensityMatrix') _DensityMatrix_>.


%% Set Observables
% Use the following command to set initial state
observables = sol.GetObservables(spin_collection);
cellfun(@(obs) obs.name, observables, 'UniformOutput', false)
%%
% See <matlab:doc('model.phy.QuantumOperator.SpinOperator.Observables') _Observables_>.

%% State Evolution
% Use the following command to perform state evolution calculations
dynamics = sol.StateEvolve(liouvillian, density_matrix);
%%
% See <matlab:doc('model.phy.Dynamics.QuantumDynamics') _QuantumDynamics_>.

%% Mean values and Plot
% Use the following command to calculate expectation values of the
% observables.
mean_values = sol.GetMeanValues(dynamics, observables);

%%
% and use the following command to plot observable
dynamics.render.plot('sz1', @real);

%% Save Data
% Use the following command to save data
sol.StoreKeyVariables(spin_collection, hamiltonian, density_matrix, observables, dynamics, mean_values);
sol.save_solution();

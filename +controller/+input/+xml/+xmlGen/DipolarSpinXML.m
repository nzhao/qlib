clc;
p=controller.xmlparser.ParameterContainer();
%% Name
p.add_trunk('Name');
p.add_branch('Name', 'SolutionName', 'DipolarDynamics');

%% SpinCollection
p.add_trunk('SpinCollection');
p.add_branch('SpinCollection', 'Source', 'File');
p.add_branch('SpinCollection', 'FileName', '+xyz/butaneProton.xyz');

%% Condition
p.add_trunk('Condition');
p.add_branch('Condition', 'MagneticField', '1e-4*[0 0 100]');

%% Interaction
p.add_trunk('Interaction');
p.add_branch('Interaction', 'IsSecular', 1);

%% State
p.add_trunk('InitialState');
p.add_branch('InitialState', 'DensityMatrix', '1.0 * p(2)_1 * p(1)_2 * p(1)_3 * p(1)_4 * p(1)_5 * p(1)_6');
p.add_branch('InitialState', 'StateVector', '2');
p.add_branch('InitialState', 'Type', 'PureState');

%% Observable
p.add_trunk('Observable');
p.add_branch('Observable', 'ObservableNumber', 1);
p.add_branch('Observable', 'ObservableName1', 'sz1');
p.add_branch('Observable', 'ObservableString1', '1.0 * sz_1');

%% Dynamics
p.add_trunk('Dynamics');
p.add_branch('Dynamics', 'TimeList', '0:10e-6:2e-3');


%% Export
xml_file= [INPUT_FILE_PATH, '+xml/DipolarSpinDynamics1.xml'];
p.exportXML(xml_file);

type(xml_file)
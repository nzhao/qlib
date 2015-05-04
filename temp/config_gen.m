clc;
p=controller.xml.ParameterContainer();

%% Spin Bath
p.add_trunk('SpinBath');
p.add_branch('SpinBath', 'method', 'random');
p.add_branch('SpinBath', 'cut_off', 500);

%% CCE
p.add_trunk('CCE');
p.add_branch('CCE', 'max_order', 4);

%% Export
path2file='/Users/nzhao/code/lib/active/qlib/+controller/+xml/';
xml_file= [path2file, 'config.xml.example'];
p.exportXML(xml_file);

type(xml_file)

%% import
p=controller.xml.ParameterContainer();
p.importXML(xml_file);
p.get_parameter('CCE', 'max_order')


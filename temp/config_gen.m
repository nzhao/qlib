clc;
p=controller.xmlparser.ParameterContainer();

%% Spin Bath
p.add_trunk('SpinBath');
p.add_branch('SpinBath', 'method', 'random');
p.add_branch('SpinBath', 'cut_off', 500);

%% CCE
p.add_trunk('CCE');
p.add_branch('CCE', 'max_order', 4);

%% Export
xml_file= [CONFIG_FILE_PATH, 'config.xml.example'];
p.exportXML(xml_file);

type(xml_file)

%% import
p=controller.xml.ParameterContainer();
p.importXML(xml_file);
p.get_parameter('CCE', 'max_order')


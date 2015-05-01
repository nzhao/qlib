clear;clc;

spin_bath_parameter=containers.Map({'method', 'cut_off'},{'random', 500});
cce_parameter=containers.Map({'max_order'},{4});

parameter_dict=containers.Map(...
    {'SpinBath', 'CCE'},...
    {spin_bath_parameter, cce_parameter}, ...
    'UniformValues', 0);

xml_file='config.xml';
controller.xml.dict2xml(parameter_dict, xml_file);
type(xml_file)
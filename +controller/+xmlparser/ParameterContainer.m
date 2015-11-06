classdef ParameterContainer < handle
    %PARAMETERCONTAINER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dict
        configXML
        nodes
    end
    
    methods
        function obj=ParameterContainer()
            obj.dict = containers.Map();
        end
        
        function add_trunk(obj, trunk_label)
            obj.dict(trunk_label) = containers.Map();
        end
        
        function add_branch(obj, trunk_label, new_label, value)
            if obj.dict.isKey(trunk_label)
                branch = obj.dict(trunk_label);
                branch(new_label) = value;
            else
                error('no trunk label');
            end
        end
        
        function exportXML(obj, xml_filename)
            controller.xmlparser.dict2xml(obj.dict, xml_filename);
        end
        
        function importXML(obj, xml_filename)
            obj.configXML = xmlread(xml_filename);
            obj.nodes=obj.configXML.getChildNodes;
        end
        
        function para=get_parameter(obj, trunk_label, branch_label)
            trunk=obj.nodes.getElementsByTagName(trunk_label).item(0);
            branch=trunk.getElementsByTagName(branch_label).item(0);
            
            data=branch.getFirstChild.getData;
            datatype=branch.getAttributes.item(0).getFirstChild.getData;
            
            if strcmp(datatype, 'double')
                para=str2double(data);
            elseif strcmp(datatype, 'eval')
                para=eval(data);
            else
                para=char(data);
            end

        end
    end
    
end


classdef AbstractSolution < handle
    %ABSTRACTALGORITHM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        timeTag
        solutionName
        configFile
        parameters
        keyVariables
        result
        render
    end
    
    methods
        function obj=AbstractSolution(config_file)
            % On constructing a _AbstractSolution_, the constructor calls
            % the get_parameters method to parse the xml file
            
            obj.timeTag=datestr(clock,'yyyymmdd_HHMMSS');
            obj.keyVariables=containers.Map();
            p=obj.config_parser(config_file);
            obj.get_parameters(p)
        end
        function p=config_parser(obj, config_file)
            obj.configFile=config_file;
            p=controller.xmlparser.ParameterContainer();
            %          p.importXML([INPUT_FILE_PATH, '+xml/', config_file]);
            p.importXML([pwd, '/', config_file]);
        end
        
        function save_solution(obj)
            eval([obj.solutionName, '=obj;']);
            %   save([OUTPUT_FILE_PATH, obj.solutionName, obj.timeTag], obj.solutionName);
            save([pwd, '/', obj.solutionName, obj.timeTag], obj.solutionName);
        end
        
        function get_parameters(obj, p)
            obj.solutionName=p.get_parameter('Name', 'SolutionName');
        end
        
        function StoreKeyVariables(obj, varargin)
            for k=1:length(varargin)
                name_k=inputname(k+1);
                obj.result.(name_k) = varargin{k};
            end
        end
    end
    
    methods (Abstract)
        perform(obj)
    end
    
end


classdef LabCondition < handle
    %LabCondition is a singleton pattern organizing conditions.
    %   The content is stored in a containters.Map variable. Use the
    %   following methods to access the content.
    %
    %   val = LabCondition.getValue(key)
    %   LabCondition.setValue(key, val) 
    %   LabCondition.list()
    
    properties (Access = private)
        value
    end
    
    methods(Access = private)
        function obj = LabCondition()
            obj.value=containers.Map();
            obj.value('magnetic_field')=[0 0 0];
            obj.value('temperature')=300;
        end
    end

    methods(Static)
        function obj = getCondition()
            persistent localobj
            if  isempty(localobj) || ~isvalid(localobj)
                localobj = model.phy.LabCondition();
            end
            obj = localobj;
        end
    end
    
    methods
        function setValue(obj, key, val)
            % ********** set the value a given key.
            obj.value(key)=val;
        end
        function val=getValue(obj, key)
            % ********** return the value a given key.
            val=obj.value(key);
        end
        
        function list(obj)
            % ********** list all the key-value pairs.
            keys=obj.value.keys();
            disp('==============');
            for k=1:obj.value.length
                key=keys{k};
                fprintf('#%d:\t%s\n', k, key);
                disp(obj.getValue(key));
                disp('==============');
            end
            
        end
    end
    
end


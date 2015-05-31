classdef LabCondition < handle
    %ABSTRACTCONDITION Summary of this class goes here
    %   Detailed explanation goes here
    properties (Access = private)
        value
    end
    
    methods(Access = private)
        function obj = LabCondition()
            obj.value=containers.Map();
            obj.value('magnetic_field')=[0 0 0];
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
            obj.value(key)=val;
        end
        function val=getValue(obj, key)
            val=obj.value(key);
        end
    end
    
end


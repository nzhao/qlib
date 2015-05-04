classdef FromFile < model.phy.SpinCollection.SpinCollectionStrategy
    %FROMFILE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        filename
    end
    
    methods
        function generate_spin_collection(obj, filename)
            obj.filename = filename;
            disp('spin collection is generated from a file');
        end
    end
    
end


classdef FromFile < model.phy.SpinCollection.SpinCollectionStrategy
    %FROMFILE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        filename
    end
    
    methods
        function obj = FromFile(filename)
            obj.filename = filename;
            obj.strategy_name = 'FromeFile';
        end
        
        function spin_list = generate_spin_collection(obj)
            fprintf('Importing spins from %s ...\n', obj.filename);
            spin_list=controller.input.xyz.xyzFileParser(obj.filename);
        end
                
    end
    
end


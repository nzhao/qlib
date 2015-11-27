classdef SpinStateVector < model.phy.SpinStateVector.AbstractSpinStateVector
    %SPINSTATEVECTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=SpinStateVector(strategy)
            obj.hasVector=0;
            obj.vector_strategy=strategy;
        end
        
        function export_vector(obj, filename)
            v=obj.getVector();
            fileID = fopen(filename,'a');
            fwrite(fileID, real(v),'double'); 
            fwrite(fileID, imag(v),'double');
            fclose(fileID);
        end
    end
    
end


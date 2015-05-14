classdef SpinCollection < handle
    %SPINCOLLECTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_list
        spin_source
    end
    
    methods
        function obj=SpinCollection()
            obj.spin_list = {};
        end
        
        function generate(obj)
            obj.spin_list = obj.spin_source.generate_spin_collection();
        end
        
        function len=getLength(obj)
            len = length(obj.spin_list);
        end
        
        function space=getSpace(obj)
            dim_list=obj.getDimList;
            space=model.math.ProductLinearSpace(dim_list);
        end
        
        function dim_list=getDimList(obj)
            len=obj.getLength();
            
            dim_list=zeros(1, len);
            for k=1:len
                dim_list(k)=obj.spin_list{k}.dim;
            end
        end
            
    end
    
end


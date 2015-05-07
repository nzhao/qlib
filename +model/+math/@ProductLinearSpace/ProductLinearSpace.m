classdef ProductLinearSpace < math.LinearSpace
    %PRODCUTLINEARSPACE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dim_list % dimension list
        nbody
        basenum
        
        sub_idx
        subspace
        quotspace
    end
    
    methods
        function obj=ProductLinearSpace(dim_list)
            obj=obj@math.LinearSpace();
            
            obj.dim_list=dim_list;            
            obj.dim=prod(obj.dim_list);
            obj.nbody = length(obj.dim_list);

            obj.basenum=obj.get_basenum();

            is_bin=0;
            if all( dim_list==2*ones(1,obj.nbody) )
                is_bin=1;
            end
            obj.full_basis=obj.get_full_basis(is_bin);
            
        end
        
        function create_subspace(obj, sub_idx)
            obj.sub_idx=sub_idx;
            sub_dims=obj.dim_list(sub_idx);
            obj.subspace=math.ProductLinearSpace(sub_dims);
            
            quot_idx=setdiff(1:obj.nbody, obj.sub_idx);
            quot_dims=obj.dim_list(quot_idx);
            obj.quotspace=math.ProductLinearSpace(quot_dims);
        end
        

    end
    
end


classdef SpinInteraction < model.phy.SpinInteraction.GeneralSpinInteraction
    %SPINORDER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=SpinInteraction(spin_collection, spin_index, spin_mat_str, spin_coeff)
            if nargin < 4
                spin_coeff = num2cell(ones(1, length(spin_index)));
            end
            
            new_mat=calc_mat(spin_collection, spin_index, spin_mat_str);
            obj@model.phy.SpinInteraction.GeneralSpinInteraction(spin_collection, spin_index, new_mat, spin_coeff)
        end
        
    end
    
end


function mat=calc_mat(spin_collection, spin_index, spin_mat_str)
    if length(spin_index)~=length(spin_mat_str)
        error('index and mat are not equal length.');
    end

    len=length(spin_index);
    mat=cell(1, len);
    for k=1:len
        ss=spin_collection.spin_list(spin_index{k});
        
        if length(ss) ~= length(spin_mat_str{k})
            error('size does not match.');
        end
        
        mat1=1;
        for q=1:length(ss)
            mat_q=eval(['ss{q}.',spin_mat_str{k}{q}]);
            mat1=kron(mat1, mat_q);
        end
        mat{k}={mat1};
    end

end


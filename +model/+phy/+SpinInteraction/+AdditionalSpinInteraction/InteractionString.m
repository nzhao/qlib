classdef InteractionString < model.phy.SpinInteraction.AdditionalSpinInteraction.GeneralSpinInteraction
    %STRINGTOINTERACTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=InteractionString(spin_collection, str)
            if ischar(str)
                strCell=strsplit(str, ' + ');
            elseif iscell(str)
                strCell=str;
            end

            len=length(strCell);

            spin_index=cell(len, 1);
            spin_mat_str=cell(1, len);
            spin_coeff=cell(1, len);

            for k=1:len
                [idx, str, coeff]=string_convert(strCell{k});
                spin_index{k}=idx;
                spin_mat_str{k}=str;
                spin_coeff{k}=coeff;
            end
            
            new_mat=spin_collection.calc_mat(spin_index, spin_mat_str);

            obj@model.phy.SpinInteraction.AdditionalSpinInteraction.GeneralSpinInteraction(spin_collection, spin_index, new_mat, spin_coeff)
            
        end
        
        function skp=single_skp_term(obj)
            cursor=obj.iter.cursor;
            coeff=obj.parameter.spin_coeff{cursor};
            idx=obj.iter.currentIndex();
            nspin=obj.iter.spin_collection.getLength;
            
            mat_kp=obj.parameter.spin_mat{cursor}; 
            mat_cell=mat_kp.opset;
            
            opset=cell(1,nspin);
            for kk=1:nspin
                opset{kk}=1;%speye(dim_list(kk))                
            end
            for kk=1:length(idx)
                opset{idx(kk)}=mat_cell{kk};
            end
            
            opinds=1:nspin;
            skp=obj.kron_prod(coeff, opinds, opset);
        end
                
    end
    
end

function [idx, str, coeff]=string_convert(str)
    factorize=strsplit(str, ' * ');
    len=length(factorize);

    idx=zeros(1, len-1);
    str=cell(1, len-1);
    coeff=str2double(factorize{1});
    for k=2:len
        op_idx=strsplit(factorize{k},'_');
        idx(k-1)=str2double(op_idx{2});
        str{k-1}=op_idx{1};
    end
end

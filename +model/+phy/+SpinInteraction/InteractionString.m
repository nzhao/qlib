classdef InteractionString < handle
    %STRINGTOINTERACTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        spin_collection
        string_len
        string_cell
        spin_index
        spin_mat_str
        spin_coeff
    end
    
    methods
        function obj=InteractionString(spin_collection, strCell)
            obj.spin_collection=spin_collection;
            obj.string_cell=strCell;

            len=length(strCell);
            obj.string_len=len;

            obj.spin_index=cell(1, len);
            obj.spin_mat_str=cell(1, len);
            obj.spin_coeff=cell(1, len);
        end
        
        function interaction=getInteraction(obj)
            len=obj.string_len;
            
            for k=1:len
                [idx, str, coeff]=obj.string_convert(obj.string_cell{k});
                obj.spin_index{k}=idx;
                obj.spin_mat_str{k}=str;
                obj.spin_coeff{k}=coeff;
            end
            
            interaction=model.phy.SpinInteraction.SpinInteraction(obj.spin_collection,...
                obj.spin_index, obj.spin_mat_str, obj.spin_coeff);
        end
        
        function [idx, str, coeff]=string_convert(~, str)
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
    end
    
end


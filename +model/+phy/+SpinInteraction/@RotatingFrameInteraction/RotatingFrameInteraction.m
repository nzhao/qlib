classdef RotatingFrameInteraction < model.phy.SpinInteraction.LocalFieldZeemanInteraction
    %ROTATINGFRAMEINTERACTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=RotatingFrameInteraction(spin_collection, rot_freq)
            local_fields=zeros(spin_collection.getLength, 3);
            if length(rot_freq) == 1
                for k=1:spin_collection.getLength
                    local_fields(k,:)= - rot_freq * [0 0 1];
                end
            elseif length(rot_freq) == spin_collection.getLength
                for k=1:spin_collection.getLength
                    local_fields(k,:)= - rot_freq(k) * [0 0 1];
                end
            else
                error('Wrong dimension of rot_freq');
            end
            
            obj@model.phy.SpinInteraction.LocalFieldZeemanInteraction(spin_collection, local_fields);
        end
    end
    
end


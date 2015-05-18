classdef SingleSpinProjector < model.phy.QuantumOperator.Observable
    %SINGLESPINPROJECTOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=SingleSpinProjector(spin_collection, proj_spin_idx, state)
            obj@model.phy.QuantumOperator.Observable(spin_collection);
            outer_mat=state*state';
                        
            proj_inte=model.phy.SpinInteraction.GeneralSpinInteraction(...
                spin_collection, { proj_spin_idx,}, { {outer_mat}, }, { 1.0,});
            
            obj.addInteraction(proj_inte);
        end
    end
    
end


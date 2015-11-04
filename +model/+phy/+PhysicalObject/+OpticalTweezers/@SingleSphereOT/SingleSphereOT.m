classdef SingleSphereOT < model.phy.PhysicalObject.OpticalTweezers.AbstractOpticalTweezers
    %SINGLESPHERESCATTERING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Nmax
        beam
        sphere
        coeff_a
        coeff_b
        coeff_c
        coeff_d
        coeff_p
        coeff_q
        idx_m
        idx_n
        Tmatrix
        T2matrix
    end
    
    methods
        function obj=SingleSphereOT(lens, incBeam, sphere)
            obj@model.phy.PhysicalObject.OpticalTweezers.AbstractOpticalTweezers(lens, incBeam);

            obj.nScatterer=1;
            obj.sphere=sphere;
        end
        
        function prepare_coeff(obj)
            obj.beam=obj.prepare_beam();
            [a, b, n, m]  = obj.getBSC();
            [T, T2, c, d] = obj.getTmatrix();
            
            obj.coeff_a = a; obj.coeff_b = b; 
            obj.coeff_c = c; obj.coeff_d = d;
            obj.idx_n=n;     obj.idx_m=m;
            obj.Tmatrix=T;   obj.T2matrix=T2;
        end
        
        
    end
    
end


classdef AbstractAplanaticBeam < model.phy.PhysicalObject.LaserBeam.OpticalField 
    %ABSTRACTAPLANATICBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        lens
        incBeam
        focBeam
        
        f0
        gs_order
        
        amplitude=1.0;
    end
    
    methods
        function obj=AbstractAplanaticBeam(lens, inc_beam)            
            obj.lens=lens;
            obj.incBeam=inc_beam;
            
            medium2=lens.work_medium;
            wavelength2=inc_beam.wavelength/medium2.n;
            obj.focBeam=model.phy.PhysicalObject.LaserBeam.LaserBeamPartialWave('FocusedField', wavelength2, medium2.name);

            obj.f0=inc_beam.w0/lens.focal_distance/sin(lens.aMax);
            obj.gs_order=GS_INT_ORDER;
        end
        
        
        function [aList, wList]=alpha_sampling(obj, nPiece)
            nOrder=obj.gs_order;
            aList=zeros(1, nPiece*nOrder);
            wList=zeros(1, nPiece*nOrder);
            dx=obj.lens.aMax/nPiece;
            for kk=1:nPiece
                x1=(kk-1)*dx; x2=x1+dx;
                [x, w] = model.math.misc.lgwt(nOrder, x1, x2);
                aList( (kk-1)*nOrder+1: kk*nOrder ) = x(end:-1:1);
                wList( (kk-1)*nOrder+1: kk*nOrder ) = w(end:-1:1);
            end            
        end
        
        function val=get_amplitude_factor(obj)
            f=obj.lens.focal_distance;
            abs_E0= obj.incBeam.abs_E0;
            k=obj.incBeam.k;

            ikf=1.j* k * f;
            eta_f= ikf*exp(-ikf);
            val=abs_E0*eta_f;
        end
        
    end
    
    methods (Abstract)
        wavefunction(obj, x, y, z)
        getVSWFcoeff(obj, maxN)
    end

    
end


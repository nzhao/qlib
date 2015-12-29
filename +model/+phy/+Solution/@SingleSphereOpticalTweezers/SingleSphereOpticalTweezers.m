classdef SingleSphereOpticalTweezers  < model.phy.Solution.AbstractSolution
    %SINGLESPHEREOPTICALTWEEZERS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        forcefield;
    end
    
    methods
        function obj=SingleSphereOpticalTweezers(xml_file)
            obj@model.phy.Solution.AbstractSolution(xml_file);
        end
        
        function get_parameters(obj, p)
            get_parameters@model.phy.Solution.AbstractSolution(obj, p);
            
            obj.parameters.FocalDistance = p.get_parameter('Lens', 'FocalDistance');
            obj.parameters.WorkingMedium = p.get_parameter('Lens', 'Medium');
            obj.parameters.NA            = p.get_parameter('Lens', 'NA');
            
            obj.parameters.IncBeamCenter = p.get_parameter('IncBeam', 'Center');
            obj.parameters.IncBeamP_L    = p.get_parameter('IncBeam', 'P_L');
            obj.parameters.IncBeamPower  = p.get_parameter('IncBeam', 'Power');
            obj.parameters.IncBeamPxPy   = p.get_parameter('IncBeam', 'PxPy');
            obj.parameters.IncBeamWaist  = p.get_parameter('IncBeam', 'Waist');
            obj.parameters.IncBeamWaveLength  = p.get_parameter('IncBeam', 'WaveLength');
            
            obj.parameters.SpherePosition  = p.get_parameter('SphereScatterer', 'Position');
            obj.parameters.SphereRadius    = p.get_parameter('SphereScatterer', 'Radius');
            obj.parameters.SphereMedium    = p.get_parameter('SphereScatterer', 'Medium');
            
            obj.parameters.CutOffNMax = p.get_parameter('CutOff', 'NMax');
        end
        
        function [force,torque]=perform(obj)
%             import model.phy.PhysicalObject.Lens
            
            lens          = obj.getLens();
            paraxial_beam = obj.getIncBeam();
            sphere        = obj.getScatterer();
            
            focal_beam    = obj.makeFocalBeam(lens, paraxial_beam);            
            [T, T2]       = obj.getTmatrix(sphere);
            
            total_beam    = obj.makeTotalBeam(sphere,focal_beam, T, T2);
            [force,torque]= obj.calForce(total_beam);
            
            obj.StoreKeyVariables(lens, paraxial_beam, sphere, focal_beam, T, T2, total_beam, force);
        end
%         
%         function makeForceField(obj)
%             import model.phy.PhysicalObject.VectorField
%             obj.forcefield=VectorField();
%         end
            
        function force = wavefunction(obj,x,y,z)
            obj.parameters.SpherePosition=[x,y,z];
            force=obj.perform();                 
        end
%         function [data, fig]= lineCut(obj, r0, r1, n, component)
%         end
    end
    
end


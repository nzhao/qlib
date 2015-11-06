classdef AlkaliAtom < model.phy.PhysicalObject.Atom.AbstractAtom
    %ALKALIATOM Summary of this class goes here
    %   Detailed explanation goes here
        
    properties
        nSpin
        gSpin
        e1Spin
        e2Spin
        
        dimG
        dimE1
        dimE2
        
        beam
    end
    
    methods
        function obj = AlkaliAtom(name)
            obj@model.phy.PhysicalObject.Atom.AbstractAtom(name);
            obj.parameters=model.phy.data.AtomicStructure.get_parameters(name);
            obj.dim=obj.parameters.dim;
            
            import model.phy.PhysicalObject.Spin
            
            obj.nSpin=Spin(name);
            obj.gSpin=Spin('E');
            obj.e1Spin=Spin('J1/2');
            obj.e2Spin=Spin('J3/2');
            
            obj.dimG=obj.gSpin.dim * obj.nSpin.dim;
            obj.dimE1=obj.e1Spin.dim * obj.nSpin.dim;
            obj.dimE2=obj.e2Spin.dim * obj.nSpin.dim;
        end
        
    end
    
end


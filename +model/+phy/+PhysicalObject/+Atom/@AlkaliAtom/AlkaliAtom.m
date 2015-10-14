classdef AlkaliAtom < model.phy.PhysicalObject.Atom.AbstractAtom
    %ALKALIATOM Summary of this class goes here
    %   Detailed explanation goes here
        
    properties
    end
    
    methods
        function obj = AlkaliAtom(name)
            obj@model.phy.PhysicalObject.Atom.AbstractAtom(name);
            obj.parameters=model.phy.data.AtomicStructure.get_parameters(name);
            obj.dim=obj.parameters.dim;
        end
        
    end
    
end


classdef NV < model.phy.PhysicalObject.PhysicalObject
    %NV Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        espin
        nspin
        
    end
    
    methods
        function obj=NV(parameters)
            try
                orientation=parameters.orientation;
            catch
                orientation=[1 1 1];
            end
            
            try
                isotope=parameters.isotope;
            catch
                isotope='14N';
            end
            
            try
                coordinate=parameters.coordinate;
            catch
                coordinate=[0 0 0];
            end
            
            obj.nspin=model.phy.PhysicalObject.Spin(isotope, coordinate);
            obj.espin=model.phy.PhysicalObject.Spin('NVespin', coordinate + orientation*DIAMOND_LATTICE_CONST/4);
            obj.espin.ZFS=2*pi*2.87e9;
            obj.espin.orientation=orientation;
        end
        
    end
    
end


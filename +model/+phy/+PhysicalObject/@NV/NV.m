classdef NV < model.phy.PhysicalObject.PhysicalObject
    %NV Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        magnetic_field
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
            
            try
                obj.magnetic_field=parameters.B;
            catch
                obj.magnetic_field=[0 0 0];
            end
                
            
            obj.nspin=model.phy.PhysicalObject.Spin(isotope, coordinate);
            obj.espin=model.phy.PhysicalObject.Spin('NVespin', coordinate + orientation*DIAMOND_LATTICE_CONST/4);
            
            obj.espin.ZFS=2*pi*2.87e9;
            obj.espin.principle_axis=orientation;
        end
        
        function hami=get_ESpinHamiltonian(obj)
            nvE=SpinCollection();
            nvE.spin_source = model.phy.SpinCollection.Strategy.FromSpinList({obj.espin});
            nvE.generate();

            para.B=obj.magnetic_field;
            % para.rotation_frequency=para.B*cluster_NVe.spin_list{1}.gamma;
            hami=Hamiltonian(nvE);
            hami.addInteraction( ZeemanInteraction(nvE, para) );
            hami.generate_matrix();
        end
    end
    
end


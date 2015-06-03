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
            if nargin == 0
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
            end
            
            condition=model.phy.LabCondition.getCondition;
            obj.magnetic_field=condition.getValue('magnetic_field');
            
            obj.nspin=model.phy.PhysicalObject.Spin(isotope, coordinate);
            coord_espin=coordinate + orientation*DIAMOND_LATTICE_CONST/4;
            para.ZFS=2*pi*2.87e9;
            para.principle_axis=orientation;
            obj.espin=model.phy.PhysicalObject.Spin('NVespin',coord_espin,para);
        end
        
        function hami=get_ESpinHamiltonian(obj)
            import model.phy.SpinInteraction.ZeemanInteraction
            
            nvE=model.phy.SpinCollection.SpinCollection();
            nvE.spin_source = model.phy.SpinCollection.Strategy.FromSpinList({obj.espin});
            nvE.generate();

            para.B=obj.magnetic_field;
            hami=model.phy.QuantumOperator.SpinOperator.Hamiltonian(nvE);
            hami.addInteraction( ZeemanInteraction(nvE, para) );
            hami.generate_matrix();
        end
        
        function [state, energy]=get_ESpinEigen(obj)
            espin_hamiltonian=obj.get_ESpinHamiltonian();
            [state, energy]=eig(full(espin_hamiltonian.getMatrix));
        end
    end
    
end


 function set_central_spin(obj,p)
     %set central spin
     % get the parameters for setting the central spin e.g. ZFS, eta, principle_axis, coordinate
        obj.parameters.SetCentralSpin.name=p.get_parameter('SetCentralSpin', 'Name');
        obj.parameters.SetCentralSpin.CentralSpinStates=p.get_parameter('SetCentralSpin', 'CentralSpinStates');
        obj.parameters.SetCentralSpin.SetSpin=p.get_parameter('SetCentralSpin', 'SetSpin');
        Oritation=p.get_parameter('SetCentralSpin', 'Oritation');
        Isotope=p.get_parameter('SetCentralSpin', 'Isotope');
        Coordinate=p.get_parameter('SetCentralSpin', 'Coordinate');
        if obj.parameters.SetCentralSpin.SetSpin
            if ~strcmp(Oritation,'default') 
                obj.parameters.SetCentralSpin.CentralSpinSetting.Oritation=Oritation;
            end
            if ~strcmp(Isotope,'default') 
                obj.parameters.SetCentralSpin.CentralSpinSetting.Isotope=Isotope;
            end
            if ~strcmp(Coordinate,'default') 
                obj.parameters.SetCentralSpin.CentralSpinSetting.Coordinate=Coordinate;
            end
        end
end
    


function set_bath_spin(obj, p)
     %set bath spin
     % get the parameters for setting the bath spins e.g. ZFS, eta, principle_axis, coordinate
        obj.parameters.SetBathSpins.SetSpin=p.get_parameter('SetBathSpins','SetSpin');
        if obj.parameters.SetBathSpins.SetSpin
            SpeciesNumber=p.get_parameter('SetBathSpins','SpeciesNumber');
            BathSpinsSettingCell=cell(1,4);
            NameList=p.get_parameter('SetBathSpins','Name');
            ZFSList=p.get_parameter('SetBathSpins','ZFS');
            etaList=p.get_parameter('SetBathSpins','eta');
            paxisList=p.get_parameter('SetBathSpins','principle_axis');
            for k=1:SpeciesNumber
                BathSpinsSettingCell{k}.name=NameList(k,:);
                BathSpinsSettingCell{k}.ZFS=ZFSList(k,:);
                if ~strcmp(etaList,'default')                   
                    BathSpinsSettingCell{k}.eta=etaList(k,:);
                end
                if ~strcmp(paxisList,'default')                   
                    BathSpinsSettingCell{k}.principle_axis=paxisList(k,:);
                end                  
            end
            obj.parameters.SetBathSpins.BathSpinsSettingCell=BathSpinsSettingCell;               
        end
end


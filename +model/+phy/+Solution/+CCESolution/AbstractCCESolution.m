classdef AbstractCCESolution < model.phy.Solution.AbstractSolution
    %ABSTRACTCCESOLUTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=AbstractCCESolution(xml_file)
            obj@model.phy.Solution.AbstractSolution(xml_file);
        end
        
        function BathSpinParameters(obj, p)
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
        
         function CentralSpinParameters(obj,p)
             %set central spin
             % get the parameters for setting the central spin e.g. ZFS, eta, principle_axis, coordinate
                obj.parameters.SetCentralSpin.name=p.get_parameter('SetCentralSpin', 'Name');
                obj.parameters.SetCentralSpin.CentralSpinStates=p.get_parameter('SetCentralSpin', 'CentralSpinStates');
                obj.parameters.SetCentralSpin.SetSpin=p.get_parameter('SetCentralSpin', 'SetSpin');
                Orientation=p.get_parameter('SetCentralSpin', 'Orientation');
                Isotope=p.get_parameter('SetCentralSpin', 'Isotope');
                Coordinate=p.get_parameter('SetCentralSpin', 'Coordinate');
                if obj.parameters.SetCentralSpin.SetSpin
                    if ~strcmp(Orientation,'default') 
                        obj.parameters.SetCentralSpin.orientation=Orientation;
                    end
                    if ~strcmp(Isotope,'default') 
                        obj.parameters.SetCentralSpin.isotope=Isotope;
                    end
                    if ~strcmp(Coordinate,'default') 
                        obj.parameters.SetCentralSpin.coordinate=Coordinate;
                    end
                end
        end
    end
    
end


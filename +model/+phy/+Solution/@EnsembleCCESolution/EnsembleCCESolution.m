classdef EnsembleCCESolution < model.phy.Solution.AbstractSolution
    %ENSEMBLECCESOLUTION Summary of this class goes here
    %   EnsembleCCESolution needs the following input paramters:
    %   1. parameters.SpinCollectionStrategy
    %   2. parameters.InputFile
    %   3. parameters.BathSpinsSetting
    %   5. parameters.MagneticField
    %   6. parameters.IsSecularApproximation
    %   7. parameters.NPulse
    %   8. parameters.CentralSpinSetting
    
    %   7. parameters.NTime
    %     parameters.TMax
    
    
    properties
    end
    
    methods
        function obj=EnsembleCCESolution(xml_file)
            obj@model.phy.Solution.AbstractSolution(xml_file);
        end
        
        function get_parameters(obj, p)
            get_parameters@model.phy.Solution.AbstractSolution(obj, p);
            
            obj.parameters.SpinCollectionStrategy=p.get_parameter('SpinCollection', 'Source');
            obj.parameters.InputFile=p.get_parameter('SpinCollection', 'FileName');
            
            obj.parameters.BathSpinsSetting.SetSpin=p.get_parameter('BathSpinsSetting','SetSpin');
            if obj.parameters.BathSpinsSetting.SetSpin
                SpeciesNumber=p.get_parameter('BathSpinsSetting','SpeciesNumber');
                BathSpinsSettingCell=cell(4);
                NameList=p.get_parameter('BathSpinsSetting','Name');
                ZFSList=p.get_parameter('BathSpinsSetting','ZFS');
                etaList=p.get_parameter('BathSpinsSetting','eta');
                paxisList=p.get_parameter('BathSpinsSetting','principle_axis');
                for k=1:SpeciesNumber
                    BathSpinsSettingCell{k}.name=NameList(k);
                    BathSpinsSettingCell{k}.ZFS=ZFSList(k);
                    if ~strcmp(etaList,'default')                   
                        BathSpinsSettingCell{k}.eta=etaList(k);
                    end
                    if ~strcmp(paxisList,'default')                   
                        BathSpinsSettingCell{k}.principle_axis=paxisList(k,:);
                    end
                    
                end
                obj.parameters.BathSpinsSetting.BathSpinsSettingCell=BathSpinsSettingCell;               
            end
            
            obj.parameters.MagneticField=p.get_parameter('Condition', 'MagneticField');
            obj.parameters.IsSecularApproximation=p.get_parameter('Interaction', 'IsSecular');
 
            

            obj.parameters.TimeList=p.get_parameter('Dynamics', 'TimeList');
        end
        
        function perform(obj)
            para=obj.parameters;
          %% Package import
            %physical objects
            import model.phy.LabCondition
            import model.phy.SpinCollection.SpinCollection

            %quantum operators
            import model.phy.QuantumOperator.SpinOperator.Hamiltonian
            import model.phy.QuantumOperator.SpinOperator.DensityMatrix
            import model.phy.QuantumOperator.SpinOperator.Observable
            import model.phy.Dynamics.QuantumDynamics

            %interactoins
            import model.phy.SpinInteraction.ZeemanInteraction
            import model.phy.SpinInteraction.DipolarInteraction
            import model.phy.SpinApproximation.SpinSecularApproximation
            %strategies
            import model.phy.SpinCollection.Strategy.FromFile
            import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution

          %% Set Condition
            Condition=LabCondition.getCondition;
            Condition.setValue('magnetic_field', para.MagneticField);

          %% FromSpinList 
           switch para.SpinCollectionStrategy
               case 'File'
                   spin_collection=SpinCollection( FromFile(...
                       [INPUT_FILE_PATH, para.InputFile]));
               case 'SpinList'
                   error('not surported so far.');
           end
           obj.keyVariables('spin_collection')=spin_collection;

          %% Gernate Hamiltonian and Liouvillian Operator
            hami=Hamiltonian(spin_collection);
            hami.addInteraction( ZeemanInteraction(spin_collection) );
            hami.addInteraction( DipolarInteraction(spin_collection) );
            
            if para.IsSecularApproximation
                hami.apply_approximation( SpinSecularApproximation(spin_collection) );
            end
            liou=hami.circleC();
            obj.keyVariables('hamiltonian')=hami;
            
            %% DensityMatrix
            denseMat=DensityMatrix(spin_collection, para.InitialState);
            obj.keyVariables('densityMatrix')=denseMat;

            %% Observable
            obs=[];
            for k=1:para.ObservableNumber
                obs=[obs, Observable(spin_collection, para.ObservableName{k}, para.ObservableString{k})]; %#ok<AGROW>
            end
            obj.keyVariables('observables')=obs;

            %% Evolution
            dynamics=QuantumDynamics( MatrixVectorEvolution(liou) );
            dynamics.set_initial_state(denseMat);
            dynamics.set_time_sequence(para.TimeList);
            dynamics.addObervable(obs);
            dynamics.calculate_mean_values();
            obj.keyVariables('dynamics')=dynamics;
            
            obj.render=dynamics.render;
            obj.result=obj.render.get_result();
        end
               
        
    end
    
end


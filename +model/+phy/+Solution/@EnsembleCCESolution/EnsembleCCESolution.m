classdef EnsembleCCESolution < model.phy.Solution.AbstractSolution
    %ENSEMBLECCESOLUTION Summary of this class goes here
    %   EnsembleCCESolution needs the following input paramters:
    %   1. parameters.SpinCollectionStrategy
    %   2. parameters.InputFile
    %   3. parameters.SetBathSpins
    %   4. parameters.SetCentralSpin 
    %   5. parameters.MagneticField
    %   6.parameters.CutOff
    %   7.parameters.MaxOrder    
    %   9. parameters.IsSecularApproximation
    %   6. parameters.NPulse
    %   10. parameters.NTime
    %   11. parameters.TMax

   
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
            
            obj.set_bath_spin(p);
            obj.set_central_spin(p);
            
            obj.parameters.CutOff=p.get_parameter('Clustering', 'CutOff');
            obj.parameters.MaxOrder=p.get_parameter('Clustering', 'MaxOrder');
                                  
            obj.parameters.MagneticField=p.get_parameter('Condition', 'MagneticField');
            obj.parameters.IsSecularApproximation=p.get_parameter('Interaction', 'IsSecular');
 
            obj.parameters.NTime=p.get_parameter('Dynamics', 'NTime');
            obj.parameters.TMax=p.get_parameter('Dynamics', 'TMax');
            obj.parameters.NPulse=p.get_parameter('Dynamics', 'NPulse');
        end
        
        function set_bath_spin(obj, p)
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
        
        function set_central_spin(obj,p)
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
        
        function perform(obj)
            para=obj.parameters;
          %% Package import
            %physical objects
            import model.phy.LabCondition
            import model.phy.PhysicalObject.NV
            import model.phy.SpinCollection.SpinCollection

            %quantum operators
            import model.phy.QuantumOperator.SpinOperator.Hamiltonian
            import model.phy.QuantumOperator.SpinOperator.DensityMatrix
            import model.phy.QuantumOperator.SpinOperator.Observable
            import model.phy.Dynamics.QuantumDynamics

            %interactoins
            import model.phy.SpinInteraction.ZeemanInteraction
            import model.phy.SpinInteraction.DipolarInteraction
            %strategies
            import model.phy.SpinCollection.Strategy.FromFile
            import model.phy.SpinCollection.Strategy.FromSpinList
%             import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution
%             import model.phy.Dynamics.EvolutionKernel.ECCEMatrixEvolution

            import model.phy.SpinCollection.Iterator.ClusterIterator
            import model.phy.SpinCollection.Iterator.ClusterIteratorGen.CCE_Clustering

            import model.phy.SpinApproximation.SpinSecularApproximation

          %% Set Condition
            Condition=LabCondition.getCondition;
            Condition.setValue('magnetic_field', para.MagneticField);

          %%  Generate Spin Collection FromSpinList and generate clusters
           switch para.SpinCollectionStrategy
               case 'File'
                   spin_collection=SpinCollection( FromFile(...
                       [INPUT_FILE_PATH, para.InputFile]));
                   if para.SetBathSpins.SetSpin;
                       paraCell=para.SetBathSpins.BathSpinsSettingCell;
                       spin_collection.set_spin(paraCell);
                   end
               case 'SpinList'
                   error('not surported so far.');
           end
           obj.keyVariables('spin_collection')=spin_collection;
           
           clu_para.cutoff=para.CutOff;
           clu_para.max_order=para.MaxOrder;
           cce=CCE_Clustering(spin_collection, clu_para);
           cluster_collection=ClusterIterator(spin_collection,cce);
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%Start from here%%%%%%%%%%%%%
           
           obj.keyVariables('cluster_collection')=cluster_collection;
          %% Gernate Hamiltonian and Liouvillian Operator
            NVcenter=NV();

            NVe={NVcenter.espin};
            bath_cluster=cluster_collection.getItem(86);
            cluster=SpinCollection( FromSpinList([NVe, bath_cluster]) );
            hami_cluster=Hamiltonian(cluster);
            hami_cluster.addInteraction( ZeemanInteraction(cluster) );
%             obj.keyVariables('hamiltonian')=hami;
            
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


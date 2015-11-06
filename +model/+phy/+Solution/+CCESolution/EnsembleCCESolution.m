classdef EnsembleCCESolution < model.phy.Solution.CCESolution.AbstractCCESolution
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
    %   12. parameters.TimeList

   
    properties
    end
    
    methods
        function obj=EnsembleCCESolution(xml_file)
            obj@model.phy.Solution.CCESolution.AbstractCCESolution(xml_file);
        end
        
        function get_parameters(obj, p)
            get_parameters@model.phy.Solution.AbstractSolution(obj, p);
            obj.parameters.LoadSpinCollection=p.get_parameter('SpinCollection','LoadSpinCollection');
            if obj.parameters.LoadSpinCollection
                obj.parameters.SpinCollectionStrategy=p.get_parameter('SpinCollection', 'Source');
                obj.parameters.InputFile=p.get_parameter('SpinCollection', 'FileName');
                obj.BathSpinParameters(p);
                disp('spin collection loaded.');
            end
                        
            obj.parameters.load_cluster_iter=p.get_parameter('Clustering','LoadCluterIterator');
            if obj.parameters.load_cluster_iter
                CluterIteratorName=p.get_parameter('Clustering','CluterIteratorName');
                data=load([OUTPUT_FILE_PATH,CluterIteratorName]);
                obj.keyVariables('cluster_iterator')=data.cluster_iterator;
                disp('cluster_iterator loaded.');
            else
                obj.parameters.CutOff=p.get_parameter('Clustering', 'CutOff');
                obj.parameters.MaxOrder=p.get_parameter('Clustering', 'MaxOrder');
            end

            obj.CentralSpinParameters(p);                      
            obj.parameters.MagneticField=p.get_parameter('Condition', 'MagneticField');
            obj.parameters.IsSecularApproximation=p.get_parameter('Interaction', 'IsSecular');
 
            obj.parameters.CCEStrategy=p.get_parameter('Dynamics','CCEStrategy');
            NTime=p.get_parameter('Dynamics', 'NTime');
            TMax=p.get_parameter('Dynamics', 'TMax');
            dt=TMax/(NTime-1);
            obj.parameters.TimeList=0:dt:TMax;
            obj.parameters.NTime=NTime;
            obj.parameters.TMax=TMax;
            obj.parameters.NPulse=p.get_parameter('Dynamics', 'NPulse');
        end
        
        
        
           
        function perform(obj)
            para=obj.parameters;
          %% Package import
            %physical objects
            import model.phy.LabCondition
            import model.phy.PhysicalObject.NV
            import model.phy.SpinCollection.SpinCollection

                %strategies
            import model.phy.SpinCollection.Strategy.FromFile
            import model.phy.SpinCollection.Strategy.FromSpinList
            import model.phy.SpinCollection.Iterator.ClusterIterator
            import model.phy.SpinCollection.Iterator.ClusterIteratorGen.CCE_Clustering

          %% Set Condition
            Condition=LabCondition.getCondition;
            Condition.setValue('magnetic_field', para.MagneticField);

          %%  Generate Spin Collection FromSpinList and generate clusters
          if para.load_cluster_iter             
             cluster_iterator=obj.keyVariables('cluster_iterator');
          else             
              switch para.SpinCollectionStrategy
                   case 'File'
                       spin_collection=SpinCollection( FromFile(...
                           [INPUT_FILE_PATH, para.InputFile]));
                       if para.SetBathSpins.SetSpin;
                           paraCell=para.SetBathSpins.BathSpinsSettingCell;
                           spin_collection.set_spin(paraCell);
                       else
                           spin_collection.set_spin();
                       end
                   case 'SpinList'
                       error('not surported so far.');
               end
               obj.keyVariables('spin_collection')=spin_collection;

               clu_para.cutoff=para.CutOff;
               clu_para.max_order=para.MaxOrder;
               disp('clustering begins...')
               tic
               % the cce strategy can be change
               cce=CCE_Clustering(spin_collection, clu_para);

               cluster_iterator=ClusterIterator(spin_collection,cce);
               obj.keyVariables('cluster_iterator')=cluster_iterator;
               save([OUTPUT_FILE_PATH, 'cluster_iterator', obj.timeTag, '.mat'],'cluster_iterator');
               toc
           end
           
           
           
           center_spin_name=para.SetCentralSpin.name;
           para_central_spin=para.SetCentralSpin; 
           center_spin=eval(strcat(center_spin_name,'(','para_central_spin',')'));
           obj.keyVariables('center_spin')=center_spin;
           
           center_spin_states=para.SetCentralSpin.CentralSpinStates;
           timelist=para.TimeList;
           npulse=para.NPulse;
           is_secular=para.IsSecularApproximation;
           MagneticField=para.MagneticField;
           
           strategy_name=para.CCEStrategy;        
           total_coherence=model.phy.Solution.CCESolution.CCECoherenceStrategy.CCETotalCoherence(cluster_iterator,center_spin,strategy_name);           
           total_coherence.calculate_total_coherence(center_spin_states,timelist,'npulse',npulse,'is_secular',is_secular,'magnetic_field',MagneticField);
           
           ncluster=cluster_iterator.cluster_info.cluster_number;
           if ncluster<20000;
               obj.keyVariables('coherence_matrix')=total_coherence.coherence_matrix;
               obj.keyVariables('cluster_coherence_tilde_matrix')=total_coherence.cluster_coherence_tilde_matrix;
           end
           obj.keyVariables('coherence')=total_coherence.coherence;
%            obj.render=dynamics.render;
%            obj.result=obj.render.get_result();
        end
%         function cluster=getCluster(obj,index)
%            import model.phy.SpinCollection.SpinCollection
%            import model.phy.SpinCollection.Strategy.FromSpinList
%            cluster_collection=obj.keyVariables('cluster_collection');
%            bath_cluster=cluster_collection.getItem(index);
%            center_spin=obj.keyVariables('center_spin');
%            central_espin={center_spin.espin};
%            cluster=SpinCollection( FromSpinList([central_espin, bath_cluster]) );
%         end

        
    end
    
end


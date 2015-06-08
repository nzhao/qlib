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
    %   12. parameters.TimeList

   
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
            
            obj.BathSpinParameters(p);
            obj.CentralSpinParameters(p);
            
            obj.parameters.CutOff=p.get_parameter('Clustering', 'CutOff');
            obj.parameters.MaxOrder=p.get_parameter('Clustering', 'MaxOrder');
                                  
            obj.parameters.MagneticField=p.get_parameter('Condition', 'MagneticField');
            obj.parameters.IsSecularApproximation=p.get_parameter('Interaction', 'IsSecular');
 
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
           % the cce strategy can be change
           cce=CCE_Clustering(spin_collection, clu_para);
           cluster_collection=ClusterIterator(spin_collection,cce);
           obj.keyVariables('cluster_collection')=cluster_collection;

           center_spin_name=para.SetCentralSpin.name;
           para_central_spin=para.SetCentralSpin; 
           center_spin=eval(strcat(center_spin_name,'(','para_central_spin',')'));
           obj.keyVariables('center_spin')=center_spin;
%            obj.CoherenceTotal();
          obj.CoherenceTotalParallel();
%             obj.render=dynamics.render;
%             obj.result=obj.render.get_result();
        end
        function cluster=getCluster(obj,index)
           import model.phy.SpinCollection.SpinCollection
           import model.phy.SpinCollection.Strategy.FromSpinList
           cluster_collection=obj.keyVariables('cluster_collection');
           bath_cluster=cluster_collection.getItem(index);
           center_spin=obj.keyVariables('center_spin');
           central_espin={center_spin.espin};
           cluster=SpinCollection( FromSpinList([central_espin, bath_cluster]) );
        end

        
    end
    
end


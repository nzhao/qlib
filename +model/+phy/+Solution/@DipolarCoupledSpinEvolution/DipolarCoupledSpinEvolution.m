classdef DipolarCoupledSpinEvolution < model.phy.Solution.AbstractSolution
    %DipolarCoupledSpinEvolution calculates coherence evolution of Dipolar
    %coupled spin system.
    %   DipolarCoupledSpinEvolution needs the following input paramters:
    %   1. parameters.SpinCollectionStrategy
    %   2. parameters.InputFile
    %   3. parameters.MagneticField
    %   4. parameters.IsSecularApproximation
    %   5. parameters.InitialState
    %   6. parameters.ObservableNumber
    %   7. parameters.ObservableName
    %   8. parameters.ObservableString
    %   9. parameters.TimeList
    
    properties
    end
    
    methods
        function obj=DipolarCoupledSpinEvolution(xml_file)
            obj@model.phy.Solution.AbstractSolution(xml_file);
        end
        function get_parameters(obj, p)
            get_parameters@model.phy.Solution.AbstractSolution(obj, p);
            
            obj.parameters.SpinCollectionStrategy=p.get_parameter('SpinCollection', 'Source');
            obj.parameters.InputFile=p.get_parameter('SpinCollection', 'FileName');
            obj.parameters.MagneticField=p.get_parameter('Condition', 'MagneticField');
            obj.parameters.IsSecularApproximation=p.get_parameter('Interaction', 'IsSecular');
            obj.parameters.InitialState=p.get_parameter('InitialState', 'DensityMatrix');
            
            obj.parameters.ObservableNumber=p.get_parameter('Observable', 'ObservableNumber');
            nObs=obj.parameters.ObservableNumber;
            obj.parameters.ObservableName=cell(1,nObs);
            obj.parameters.ObservableString=cell(1,nObs);
            for k=1:nObs
                obj.parameters.ObservableName{k}=p.get_parameter('Observable', ['ObservableName',num2str(k)]);
                obj.parameters.ObservableString{k}=p.get_parameter('Observable', ['ObservableString',num2str(k)]);
            end
            obj.parameters.TimeList=p.get_parameter('Dynamics', 'TimeList');
        end
            
        function perform(obj)
            para=obj.parameters;
          
            %%% Package import
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

          %%% Set Condition
            Condition=LabCondition.getCondition;
            Condition.setValue('magnetic_field', para.MagneticField);

          %%% FromSpinList 
           switch para.SpinCollectionStrategy
               case 'File'
                   spin_collection=SpinCollection( FromFile(...
                       [INPUT_FILE_PATH, para.InputFile]));
               case 'SpinList'
                   error('not surported so far.');
           end
           spin_collection.set_spin();
           obj.keyVariables('spin_collection')=spin_collection;

          %%% Gernate Hamiltonian and Liouvillian Operator
            hami=Hamiltonian(spin_collection);
            hami.addInteraction( ZeemanInteraction(spin_collection) );
            hami.addInteraction( DipolarInteraction(spin_collection) );
            
            if para.IsSecularApproximation
                hami.apply_approximation( SpinSecularApproximation(spin_collection) );
            end
            liou=hami.circleC();
            obj.keyVariables('hamiltonian')=hami;
            
            %%% DensityMatrix
            denseMat=DensityMatrix(spin_collection, para.InitialState);
            obj.keyVariables('densityMatrix')=denseMat;

            %%% Observable
            obs={};
            for k=1:para.ObservableNumber
                obs{k}=Observable(spin_collection, para.ObservableName{k}, para.ObservableString{k});
            end
            obj.keyVariables('observables')=obs;

            %%% Evolution
            dynamics=QuantumDynamics( MatrixVectorEvolution(liou) );
            dynamics.set_initial_state(denseMat,'Liouville');
            dynamics.set_time_sequence(para.TimeList);
            dynamics.addObervable(obs);
            dynamics.calculate_mean_values();
            obj.keyVariables('dynamics')=dynamics;
            
            obj.render=dynamics.render;
            obj.result=obj.render.get_result();
        end
        
        function export2GPU_Engine(obj, filename)
            hami=obj.keyVariables('hamiltonian');
            liou=hami.circleC();
            liouMat=liou.getMatrix();

            state=obj.keyVariables('densityMatrix');
            stateVect=full(state.getVector());
            
            timeList=obj.parameters.TimeList;
            nt=length(timeList);
            
            [dim,~]=size(liouMat);
            nonzero=nnz(liouMat);
            [iaT, jaT, a]=find(liouMat.');
            ia=jaT;
            ja=iaT;
            
            fileID = fopen(filename,'w');
            fwrite(fileID, dim,'int');
            fwrite(fileID, nonzero,'int');
            fwrite(fileID, nt,'int');
            
            fwrite(fileID, ia, 'int');
            fwrite(fileID, ja, 'int');
            fwrite(fileID, real(a), 'double');
            fwrite(fileID, imag(a), 'double');
            fwrite(fileID, real(stateVect), 'double');
            fwrite(fileID, imag(stateVect), 'double');
            fwrite(fileID, timeList, 'double');
            fclose(fileID);
            
        end
    end
    
end


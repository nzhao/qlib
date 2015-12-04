classdef SpinChainSolution < model.phy.Solution.AbstractSolution
    %XYMODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=SpinChainSolution(xml_file)
            obj@model.phy.Solution.AbstractSolution(xml_file);
        end
        
        function get_parameters(obj, p)
            get_parameters@model.phy.Solution.AbstractSolution(obj, p);
            
            obj.parameters.SpinCollectionStrategy = p.get_parameter('SpinCollection', 'Source');
            obj.parameters.spinType = p.get_parameter('SpinCollection', 'SpinType');
            obj.parameters.nspin  = p.get_parameter('SpinCollection', 'SpinNum');
            obj.parameters.onSite = p.get_parameter('Interaction', 'OnSite');
            obj.parameters.dqtInt = p.get_parameter('Interaction', 'DqtInt');
            obj.parameters.xyInt = p.get_parameter('Interaction', 'XYInt');
            obj.parameters.TimeList = p.get_parameter('Dynamics',  'TimeList');
            
            %%iniital state
            tp=p.get_parameter('InitialState', 'Type');
            switch tp
                case 'MixedState'
                    st=p.get_parameter('InitialState', 'DensityMatrix');
                case 'PureState'
                    st=p.get_parameter('InitialState', 'StateVector');
                otherwise
                    error('InitialStateType "%s" is not supported.', tp);
            end
            obj.parameters.InitialStateType = tp;
            obj.parameters.InitialState = st;
            
            %Clustering states
                                    
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
            
            
            
            %%Observables
            nObs=p.get_parameter('Observable', 'ObservableNumber');
            obs_name=cell(1,nObs);  obs_str=cell(1,nObs);
            for k=1:nObs
                obs_name{k} = p.get_parameter('Observable', ['ObservableName',num2str(k)]);
                obs_str{k} = p.get_parameter('Observable',  ['ObservableString',num2str(k)]);
            end
            
            obj.parameters.ObservableNumber=nObs;
            obj.parameters.ObservableName=obs_name;
            obj.parameters.ObservableString=obs_str;
            
        end
        
        
        function perform(obj)
            import model.phy.QuantumOperator.MatrixStrategy.FromKronProd
            
            spin_collection=obj.GetSpinList();
            obj.keyVariables('spin_collection')=spin_collection;
            
            matrix_strategy=FromKronProd();
            [hamiltonian, liouvillian] = obj.GetHamiltonianLiouvillian(spin_collection,matrix_strategy);
            initial_state              = obj.GetInitialState(spin_collection,matrix_strategy);
            observables                = obj.GetObservables(spin_collection,matrix_strategy);
                         [~] = obj.GetStateInfo(spin_collection,initial_state);
            
            dynamics                   = obj.StateEvolve(hamiltonian, liouvillian, initial_state);
            mean_values                = obj.GetMeanValues(dynamics, observables);
                        
%              [~] = obj.GetStateInfo(spin_collection,initial_state);

            obj.StoreKeyVariables(spin_collection, hamiltonian, liouvillian, initial_state, observables, dynamics, mean_values);
        end
    end
    
end


classdef SpinChain < model.phy.Solution.AbstractSolution
    %XYMODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=SpinChain(xml_file)
            obj@model.phy.Solution.AbstractSolution(xml_file);
        end
        
        function get_parameters(obj, p)
            get_parameters@model.phy.Solution.AbstractSolution(obj, p);
            
            obj.parameters.SpinCollectionStrategy = p.get_parameter('SpinCollection', 'Source');
            obj.parameters.spinType = p.get_parameter('SpinCollection', 'SpinType');
            obj.parameters.nspin  = p.get_parameter('SpinCollection', 'SpinNum');
            obj.parameters.onSite = p.get_parameter('Interaction', 'OnSite');
            obj.parameters.dqtInt = p.get_parameter('Interaction', 'DqtInt');
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
            spin_collection=obj.GetSpinList();
            [hamiltonian, liouvillian] = obj.GetHamiltonianLiouvillian(spin_collection);
            initial_state               = obj.GetInitialState(spin_collection);
            observables                = obj.GetObservables(spin_collection);
            dynamics                   = obj.StateEvolve(hamiltonian, liouvillian, initial_state);
            mean_values                = obj.GetMeanValues(dynamics, observables);

            obj.StoreKeyVariables(spin_collection, hamiltonian, liouvillian, initial_state, observables, dynamics, mean_values);
        end
    end
    
end


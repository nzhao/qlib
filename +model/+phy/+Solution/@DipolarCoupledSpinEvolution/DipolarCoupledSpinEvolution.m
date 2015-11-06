classdef DipolarCoupledSpinEvolution < model.phy.Solution.AbstractSolution
    %DipolarCoupledSpinEvolution calculates coherence evolution of Dipolar
    %coupled spin system.
    %   DipolarCoupledSpinEvolution needs the following input paramters:
    %
    %   1.  parameters.SpinCollectionStrategy                    - 'SpinCollection' > 'Source'
    %   2.  parameters.InputFile                                 - 'SpinCollection' > 'FileName'
    %   3.  parameters.MagneticField                             - 'Condition'      > 'MagneticField'
    %   4.  parameters.IsSecularApproximation                    - 'Interaction'    > 'IsSecular'
    %   5a. parameters.InitialStateType                          - 'InitialState'   > 'MixedState/PureState'
    %   5b. parameters.InitialState                              - 'InitialState'   > 'DensityMatrix'
    %   5c. parameters.InitialState                              - 'InitialState'   > 'StateVector'
    %   6.  parameters.ObservableNumber                          - 'Observable'     > 'ObservableNumber'
    %   7.  parameters.ObservableName     [* ObservableNumber]   - 'Observable'     > 'ObservableName1...N'
    %   8.  parameters.ObservableString   [* ObservableNumber]   - 'Observable'     > 'ObservableString1...N'
    %   9.  parameters.TimeList                                  - 'Dynamics'       > 'TimeList'
    
    properties
    end
    
    methods
        function obj=DipolarCoupledSpinEvolution(xml_file)
            %Constructor needs xml file as an input. On constructing a DipolarCoupledSpinEvolution, the constructor calls the _get_parameters_ method to parse the xml file
            
            obj@model.phy.Solution.AbstractSolution(xml_file);
        end
        function get_parameters(obj, p)
            get_parameters@model.phy.Solution.AbstractSolution(obj, p);
            
            obj.parameters.SpinCollectionStrategy    = p.get_parameter('SpinCollection', 'Source');
            obj.parameters.InputFile                 = p.get_parameter('SpinCollection', 'FileName');
            obj.parameters.MagneticField             = p.get_parameter('Condition',      'MagneticField');
            obj.parameters.IsSecularApproximation    = p.get_parameter('Interaction',    'IsSecular');
            obj.parameters.TimeList                  = p.get_parameter('Dynamics',       'TimeList');
            
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
            obj.SetCondition();

            spin_collection            = obj.GetSpinList();
            [hamiltonian, liouvillian] = obj.GetHamiltonianLiouvillian(spin_collection);
            initial_state               = obj.GetInitialState(spin_collection);
            observables                = obj.GetObservables(spin_collection);
            dynamics                   = obj.StateEvolve(hamiltonian, liouvillian, initial_state);
            mean_values                = obj.GetMeanValues(dynamics, observables);
            
            obj.StoreKeyVariables(spin_collection, hamiltonian, initial_state, observables, dynamics, mean_values);
        end

    end
    
end


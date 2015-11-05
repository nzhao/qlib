function dynamics=StateEvolve(obj, hami, liou, state)
    import model.phy.Dynamics.QuantumDynamics
    import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution
    para=obj.parameters;
    
    if strcmp(obj.parameters.InitialStateType, 'MixedState')
        op=liou; 
    else
        op=hami;
    end

    dynamics=QuantumDynamics( MatrixVectorEvolution(op) );
    dynamics.set_initial_state(state,'Liouville');
    dynamics.set_time_sequence(para.TimeList);
    dynamics.evolve();
end
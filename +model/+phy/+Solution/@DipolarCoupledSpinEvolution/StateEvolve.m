function dynamics=StateEvolve(obj, liou, denseMat)
    import model.phy.Dynamics.QuantumDynamics
    import model.phy.Dynamics.EvolutionKernel.MatrixVectorEvolution
    para=obj.parameters;

    dynamics=QuantumDynamics( MatrixVectorEvolution(liou) );
    dynamics.set_initial_state(denseMat,'Liouville');
    dynamics.set_time_sequence(para.TimeList);
    dynamics.evolve();
end
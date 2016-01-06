sol=model.phy.Solution.DipolarCoupledSpinEvolution('DipolarSpinDynamics.xml');
sol.perform();
sol.save_solution();
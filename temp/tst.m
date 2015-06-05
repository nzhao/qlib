clear all;clc;

sol=model.phy.Solution.DipolarCoupledSpinEvolution('DipolarSpinDynamicsButane.xml');
sol.perform();
sol.save_solution();
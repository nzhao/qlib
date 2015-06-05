clear all;clc;
cd /Users/ylp/Documents/code/qlib;
addpath(genpath('./'));


sol=model.phy.Solution.DipolarCoupledSpinEvolution('DipolarSpinDynamicsButane.xml');
sol.perform();
sol.save_solution();
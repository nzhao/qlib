clear; clc

import model.phy.PhysicalObject.Lens
import model.phy.PhysicalObject.LaserBeam.ParaxialBeam.ParaxialLaguerreGaussianBeam

f=1.0;%focal distance in mm
NA=0.8; working_medium='air';
lens=Lens(f, NA, working_medium);

power=1.0; 
wavelength=1.0; waist=1000.0; center=[0, 0, 0];  %in micron
px=1.0; py=0.0; p=0; l=-1; 
incBeam=ParaxialLaguerreGaussianBeam(wavelength, power, waist, center, p, l, px, py);

lg2=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(lens, incBeam);
lg2.wavefunction(0, 0, 0)
lg2.getVSWFcoeff(80);
figure;dataF1=lg2.lineCut([-1, 0, 0], [1, 0, 0], 100, 'field');
figure;dataD1=lg2.lineCut([-1, 0, 0], [1, 0, 0], 100);

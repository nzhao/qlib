clear; clc

import model.phy.PhysicalObject.Lens
import model.phy.PhysicalObject.LaserBeam.ParaxialBeam.ParaxialLaguerreGaussianBeam

f=1.0;%focal distance in mm
NA=1.0; working_medium='vacuum';
lens=Lens(f, NA, working_medium);

power=1.0; 
wavelength=0.5; waist=1000.0; center=[0, 0, 0];  %in micron
px=1.0; py=0.0; p=0; l=-1; 
incBeam=ParaxialLaguerreGaussianBeam(wavelength, power, waist, center, p, l, px, py, 'vacuum');

lg2=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(lens, incBeam);
lg2.getVSWFcoeff(80);

[val1e, val1h]=lg2.wavefunction(1, 0, 0.1);
[val2e, val2h]=lg2.focBeam.wavefunction(1, 0, 0.1);


clear; clc;

import model.phy.PhysicalObject.Lens
import model.phy.PhysicalObject.LaserBeam.ParaxialBeam.ParaxialLaguerreGaussianBeam

f=1.0;%focal distance in mm
NA=1.0; working_medium='vacuum';
lens=Lens(f, NA, working_medium);

power=1.0; 
wavelength=0.5; waist=1000.0; center=[0, 0, 0];  %in micron
px=1.0; py=0.0; p=0; l=1; 
incBeam1=ParaxialLaguerreGaussianBeam(wavelength, power, waist, center, p, l, px, py, 'vacuum');
incBeam2=ParaxialLaguerreGaussianBeam(wavelength, power, waist, center, p, -l, px, py, 'vacuum');

lg1=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(lens, incBeam1);
lg2=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(lens, incBeam2);

lg1.getVSWFcoeff(80);
lg2.getVSWFcoeff(80);

x=1.0; y=0.1; z=2.1;
[eplus1d, hplus1d]=lg1.wavefunction(x, y, z);
[eplus1s, hplus1s]=lg1.focBeam.wavefunction(x, y, z);

[eminus1d, hminus1d]=lg2.wavefunction(x, y, z);
[eminus1s, hminus1s]=lg2.focBeam.wavefunction(x, y, z);

[eplus1d; eplus1s]
[eminus1d; eminus1s]
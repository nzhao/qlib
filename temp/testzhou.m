%% Initial
clear; clc;

import model.phy.PhysicalObject.Lens
import model.phy.PhysicalObject.LaserBeam.ParaxialBeam.ParaxialLaguerreGaussianBeam
import model.phy.PhysicalObject.LaserBeam.OpticalField

f=1.0;%focal distance in mm
NA=0.95; working_medium='vacuum';
lens=Lens(f, NA, working_medium);


power=0.1;
% This power is used to calc the incbeam parameters. 
%Also used as the focal plane power.
wavelength=1.064; waist=950.0; center=[0, 0, 0];  %in micron
%filling_factor = n_work_medium*waist/(f*1000)/NA
px=1.0; py=0.0; p=0; l=1; 
incBeam1=ParaxialLaguerreGaussianBeam(wavelength, power, waist, center, p, l, px, py, 'vacuum');
lg1=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(lens, incBeam1);
lg1.calcAmpFactor(power);
lg1.getVSWFcoeff(60);
lg1.focBeam.aNNZ;

%% compare single point
x=3.0; y=1.0; z=7.0;
[eplus1d, hplus1d]=lg1.wavefunction(x, y, z);
[eplus1s, hplus1s]=lg1.focBeam.wavefunction(x, y, z);%*lg1.amplitude;
[eplus1d; eplus1s]






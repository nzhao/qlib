clear; clc;

import model.phy.PhysicalObject.Lens
import model.phy.PhysicalObject.LaserBeam.ParaxialBeam.ParaxialLaguerreGaussianBeam
import model.phy.PhysicalObject.Scatterer.SphereParticle
import model.phy.PhysicalObject.OpticalTweezers.SingleSphereOT

%% focusing lens
f=1.0;  %focal distance in mm
NA=0.95; working_medium='vacuum';
lens=Lens(f, NA, working_medium);

%% incBeam
px=1.0; py=0.0; p=0; l=1; 
power=0.1; wavelength=1.064; waist=950.0; center=[0, 0, 0];  %in micron
incBeam=ParaxialLaguerreGaussianBeam(wavelength, power, waist, center, p, l, px, py, 'vacuum');

%% scatterer
sphere_radius=0.05;
sphere=SphereParticle(sphere_radius, 'sillica');


%% Optical Tweezers System
sys=SingleSphereOT(lens, incBeam, sphere);
sys.prepare_coeff();

xlist=linspace(-2,2,80)/wavelength;
path=[xlist; zeros(1, 80); zeros(1, 80)];
force=sys.radiationForce(path);
figure;
plot(xlist, force(1, :))
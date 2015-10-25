clear all; clc

epsAir=1; muAir=1;
n=3.3; epsM=n*n; muM=1.0;%medium refraction index;

wavelength=1.;intensity=1.0;f0=1.0; na=0.8; px=1.0; py=0.0;p=0; l=-3;
lg1=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(wavelength, intensity, f0, na, epsAir, muAir, epsM, muM, px, py, p,l);
lg1.getVSWFcoeff(40);
figure;dataF1=lg1.lineCut([-1, 0, 0], [1, 0, 0], 100, 'field');
figure;dataD1=lg1.lineCut([-1, 0, 0], [1, 0, 0], 100);
clear all; clc

wavelength=1.;intensity=1.0;f0=1.0; na=0.8; n1=1.0; n2=1.0; px=1.0; py=0.0;p=0; l=-3;
lg1=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(wavelength, intensity, f0, na, n1, n2, px, py, p,l);
lg1.getVSWFcoeff(40);
figure;dataF1=lg1.lineCut([-1, 0, 0], [1, 0, 0], 100, 'field');
figure;dataD1=lg1.lineCut([-1, 0, 0], [1, 0, 0], 100);

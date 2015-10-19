clear;
wavelength=1.;intensity=1.0;f0=1.0; na=0.8; n1=1.0; n2=1.0; px=1.0; py=0.0;p=0; l=3;
lg=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(wavelength, intensity, f0, na, n1, n2, px, py, p,l);
data1=lg.lineCut([-3, 0, 0], [3, 0, 0], 100);

hold on;
lg.na=0.6;
data2=lg.lineCut([-3, 0, 0], [3, 0, 0], 100);

hold on;
lg.na=0.4;
data3=lg.lineCut([-3, 0, 0], [3, 0, 0], 100);


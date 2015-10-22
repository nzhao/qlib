clear;
figure;
wavelength=1.0;intensity=1.0;f0=1.0; na=1.0; n1=1.0; n2=1.0; px=1.0; py=0.0;p=0; l=-1;
lg=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(wavelength, intensity, f0, na, n1, n2, px, py, p,l);
data1=lg.lineCut([-1, 0, 0], [1, 0, 0], 100);

hold on;
wavelength=1.0;intensity=1.0;f0=1.0; na=0.8; n1=1.0; n2=1.0; px=1.0; py=0.0;p=0; l=-1;
lg=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(wavelength, intensity, f0, na, n1, n2, px, py, p,l);
data2=lg.lineCut([-1, 0, 0], [1, 0, 0], 100);

hold on;
wavelength=1.0;intensity=1.0;f0=1.0; na=0.6; n1=1.0; n2=1.0; px=1.0; py=0.0;p=0; l=-1;
lg=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(wavelength, intensity, f0, na, n1, n2, px, py, p,l);
data3=lg.lineCut([-1, 0, 0], [1, 0, 0], 100);

hold on;
wavelength=1.0;intensity=1.0;f0=1.0; na=0.4; n1=1.0; n2=1.0; px=1.0; py=0.0;p=0; l=-1;
lg=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(wavelength, intensity, f0, na, n1, n2, px, py, p,l);
data4=lg.lineCut([-1, 0, 0], [1, 0, 0], 100);
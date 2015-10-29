%% Initial
clear; clc; clear classes;

import model.phy.PhysicalObject.Lens
import model.phy.PhysicalObject.LaserBeam.ParaxialBeam.ParaxialLaguerreGaussianBeam
import model.phy.PhysicalObject.LaserBeam.OpticalField

f=1.0;%focal distance in mm
NA=0.95; working_medium='vacuum';
lens=Lens(f, NA, working_medium);

power=1.0; 
wavelength=1.064; waist=1000.0; center=[0, 0, 0];  %in micron
px=1.0; py=0.0; p=0; l=1; 
incBeam1=ParaxialLaguerreGaussianBeam(wavelength, power, waist, center, p, l, px, py, 'vacuum');
incBeam2=ParaxialLaguerreGaussianBeam(wavelength, power, waist, center, p, -l, px, py, 'vacuum');

lg1=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(lens, incBeam1);
lg2=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(lens, incBeam2);

lg1.getVSWFcoeff(80);
lg2.getVSWFcoeff(80);

%% compare single point
x=3.0; y=1.0; z=7.0;
[eplus1d, hplus1d]=lg1.wavefunction(x, y, z);
[eplus1s, hplus1s]=lg1.focBeam.wavefunction(x, y, z);%*lg1.amplitude;
[eminus1d, hminus1d]=lg2.wavefunction(x, y, z);
[eminus1s, hminus1s]=lg2.focBeam.wavefunction(x, y, z);%*lg2.amplitude;

[eplus1d; eplus1s]
[eminus1d; eminus1s]
[eplus1d; eminus1d] 

%% normal to SI unit and test line

Ppower=0.1;
lg1.AmpFactor(Ppower);lg2.AmpFactor(Ppower);

data1=dlmread('D:\mywork\zhoulm\OpticalTrap\FScat\SphereScat\SphereScat\02fld_inc1.txt');
figure;
[data, fig]=lg1.lineCut([-2,0,0],[2,0,0],50,'ExR');
hold on;
plot(data1(:,1),data1(:,4),'b--','Linewidth',2)
figure;
[data, fig]=lg1.lineCut([-2,0,0],[2,0,0],50,'ExI');
hold on;
plot(data1(:,1),data1(:,5),'b--','Linewidth',2)
figure;
[data, fig]=lg1.lineCut([-2,0,0],[2,0,0],50,'EyR');
hold on;
plot(data1(:,1),data1(:,6),'b--','Linewidth',2)
figure;
[data, fig]=lg1.lineCut([-2,0,0],[2,0,0],50,'EyI');
hold on;
plot(data1(:,1),data1(:,7),'b--','Linewidth',2)
figure;
[data, fig]=lg1.lineCut([-2,0,0],[2,0,0],50,'EzR');
hold on;
plot(data1(:,1),data1(:,8),'b--','Linewidth',2)
figure;
[data, fig]=lg1.lineCut([-2,0,0],[2,0,0],50,'EzI');
hold on;
plot(data1(:,1),data1(:,9),'b--','Linewidth',2)
figure;
[data, fig]=lg1.lineCut([-2,0,0],[2,0,0],50,'Ea');
hold on;
plot(data1(:,1),data1(:,10),'b--','Linewidth',2)




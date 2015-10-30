%% Initial
clear; clc;

import model.phy.PhysicalObject.Lens
import model.phy.PhysicalObject.LaserBeam.ParaxialBeam.ParaxialLaguerreGaussianBeam
import model.phy.PhysicalObject.LaserBeam.OpticalField

f=1.0;%focal distance in mm
NA=0.95; working_medium='vacuum';
lens=Lens(f, NA, working_medium);

power=0.1; 
wavelength=1.064; waist=950.0; center=[0, 0, 0];  %in micron

px=1.0; py=0.0; p=0; l=1; 
incBeam1=ParaxialLaguerreGaussianBeam(wavelength, power, waist, center, p, l, px, py, 'vacuum');
lg1=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(lens, incBeam1);
lg1.AmpFactor(power);
lg1.getVSWFcoeff(40);
lg1.focBeam.aNNZ;

%% compare single point
x=3.0; y=1.0; z=7.0;
[eplus1d, hplus1d]=lg1.wavefunction(x, y, z);
[eplus1s, hplus1s]=lg1.focBeam.wavefunction(x, y, z);%*lg1.amplitude;
[eplus1d; eplus1s]


%% normal to SI unit and test line

Ppower=0.1;
lg1.AmpFactor(Ppower);

data1=dlmread('D:\mywork\zhoulm\OpticalTrap\FScat\SphereScat\SphereScat\02fld_inc1.txt');
figure;
[data, fig]=lg1.lineCut([-2,0.3,0.7],[2,0.3,0.7],50,'ExR');
hold on;
plot(data1(:,1),data1(:,4),'b--','Linewidth',2)
figure;
[data, fig]=lg1.lineCut([-2,0.3,0.7],[2,0.3,0.7],50,'ExI');
hold on;
plot(data1(:,1),data1(:,5),'b--','Linewidth',2)
figure;
[data, fig]=lg1.lineCut([-2,0.3,0.7],[2,0.3,0.7],50,'EyR');
hold on;
plot(data1(:,1),data1(:,6),'b--','Linewidth',2)
figure;
[data, fig]=lg1.lineCut([-2,0.3,0.7],[2,0.3,0.7],50,'EyI');
hold on;
plot(data1(:,1),data1(:,7),'b--','Linewidth',2)
figure;
[data, fig]=lg1.lineCut([-2,0.3,0.7],[2,0.3,0.7],50,'EzR');
hold on;
plot(data1(:,1),data1(:,8),'b--','Linewidth',2)
figure;
[data, fig]=lg1.lineCut([-2,0.3,0.7],[2,0.3,0.7],50,'EzI');
hold on;
plot(data1(:,1),data1(:,9),'b--','Linewidth',2)
figure;
[data, fig]=lg1.lineCut([-2,0.3,0.7],[2,0.3,0.7],50,'Ea');
hold on;
plot(data1(:,1),data1(:,10),'b--','Linewidth',2)





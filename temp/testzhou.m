%% This is an example of calculate 
%% The input parameters.
% clear; 
clc;
tic;
import model.phy.PhysicalObject.Lens
import model.phy.PhysicalObject.LaserBeam.ParaxialBeam.ParaxialLaguerreGaussianBeam
import model.phy.PhysicalObject.LaserBeam.OpticalField
import model.phy.PhysicalObject.Scatterer.SphereScatter
import model.phy.PhysicalObject.Scatterer.AbstractScatterer
%%Lens
f=1.0;%focal distance in mm
NA=0.95; working_medium='vacuum';
len=Lens(f, NA, working_medium);
%%incBeam
power=0.1;
% This power is used to calc the incbeam parameters. 
%Also used as the focal plane power.
wavelength=1.064; waist=950.0; center=[0, 0, 0];  %in micron
%filling_factor = n_work_medium*waist/(f*1000)/NA
px=1.0; py=0.0; p=0; l=1; 
incBeam1=ParaxialLaguerreGaussianBeam(wavelength, power, waist, center, p, l, px, py, 'vacuum');
lg1=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(len, incBeam1);
lg1.calcAmpFactor(power);
%%scatter
r_sph=[3,1,2];%scatter_center=[0,0,0];
radius =0.05;%unit um
scatter_medium='silica';
scat1=model.phy.PhysicalObject.Scatterer.SphereScatter(r_sph,radius,scatter_medium);

k=lg1.focBeam.k;
n_relative=scat1.scatter_medium.n/len.work_medium.n; %The relative unit is the wavelength in working medium of len.
Nmax=ott13.ka2nmax(k*scat1.radius);Nmax=Nmax*5;%Nmax=15;
lg1.getVSWFcoeff(Nmax);

%% calculation
%get ab and T matrix.
a0=lg1.focBeam.aNNZ(:,3);
b0=lg1.focBeam.bNNZ(:,3);
n=lg1.focBeam.aNNZ(:,1);
m=lg1.focBeam.aNNZ(:,2);
[a0,b0,n,m]=abLin2Nie(a0,b0,n,m);
[a,b,n,m] = ott13.make_beam_vector(a0,b0,n,m);

T = ott13.tmatrix_mie(Nmax,k,k*n_relative,scat1.radius);

[rt,theta,phi]=ott13.xyz2rtp(scat1.x,scat1.y,scat1.z);

R = ott13.z_rotation_matrix(theta,phi); %calculates an appropriate axis rotation off z.
D = ott13.wigner_rotation_matrix(Nmax,R);

[A,B] = ott13.translate_z(Nmax,rt);
a2 = D'*(  A * D*a +  B * D*b ); % Wigner matricies here are hermitian. Therefore in MATLAB the D' operator is the inverse of D.
b2 = D'*(  A * D*b +  B * D*a ); % In MATLAB operations on vectors are done first, therefore less calculation is done on the matricies.

pq = T * [ a2; b2 ];
p = pq(1:length(pq)/2);
q = pq(length(pq)/2+1:end);
%It's noticed that [a2,b2,p,q] are incident-scatter beam formula at sphere
%center.

%% compare single point
x=3.0; y=1.0; z=7.0;
[eplus1d, hplus1d]=lg1.wavefunction(x, y, z);
[eplus1p, hplus1p]=lg1.focBeam.wavefunction(x, y, z);
[eplus1s, hplus1s]=scattedwavefunction(x, y, z);%The total field amplitude after scattering.
[eplus1d; eplus1p;eplus1s]
%% Line compare.
figure; plot(r*wavelength,fr);
xlabel('{x} (x\mum)');
ylabel('{Q_x}');
aa = axis;
hold on
line(aa(1:2),[ 0 0 ],'linestyle',':');
line([0 0],aa(3:4),'linestyle',':');
toc





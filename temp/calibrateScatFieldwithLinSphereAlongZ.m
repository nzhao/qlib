%% This is an example of calculate 
%% The input parameters.
 clear; 
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
r_sph=[3,1,2];r_sph=[0,0,2];
radius =0.05;%unit um
scatter_medium='silica';
scat1=model.phy.PhysicalObject.Scatterer.SphereScatter(r_sph,radius,scatter_medium);

k=lg1.focBeam.k;
n_relative=scat1.scatter_medium.n/len.work_medium.n; %The relative unit is the wavelength in working medium of len.
Nmax=ott13.ka2nmax(k*scat1.radius);Nmax=Nmax*5;Nmax=40;
lg1.getVSWFcoeff(Nmax);

%%calculation
%get ab and T matrix.
a0=lg1.focBeam.aNNZ(:,3);
b0=lg1.focBeam.bNNZ(:,3);
n0=lg1.focBeam.aNNZ(:,1);
m0t=lg1.focBeam.aNNZ(:,2);
[a1,b1,n1,m1]=abLin2Nie(a0,b0,n0,m0t);
[a,b,n,m] = ott13.make_beam_vector(a1,b1,n1,m1);

[T, T2] = ott13.tmatrix_mie(Nmax,k,k*n_relative,scat1.radius);

[rt,theta,phi]=ott13.xyz2rtp(scat1.x,scat1.y,scat1.z);

R = ott13.z_rotation_matrix(theta,phi); %calculates an appropriate axis rotation off z.
D = ott13.wigner_rotation_matrix(Nmax,R);

[A,B] = ott13.translate_z(Nmax,rt/wavelength);
a2 = D'*(  A * D*a +  B * D*b ); % Wigner matricies here are hermitian. Therefore in MATLAB the D' operator is the inverse of D.
b2 = D'*(  A * D*b +  B * D*a ); % In MATLAB operations on vectors are done first, therefore less calculation is done on the matricies.

pq = T * [ a2; b2 ];
p = pq(1:length(pq)/2);
q = pq(length(pq)/2+1:end);
%It's noticed that [a2,b2,p,q] are incident-scatter beam formula at sphere
%center.
cd = T2 * [ a2; b2 ];
c = cd(1:length(cd)/2);
d = cd(length(cd)/2+1:end);

totalBeam1=totalBeam(n,m,a2,b2,p,q,c,d,scat1,lg1);
%% compare single point
x=2.0; y=1.0; z=3.0;
[eplus1d, hplus1d]=lg1.wavefunction(x, y, z);
[eplus1p, hplus1p]=lg1.focBeam.wavefunction(x, y, z);
%a single point comparation with incident field.
x=x-r_sph(1);y=y-r_sph(2);z=z-r_sph(3);
[eplus1s, hplus1s]=totalBeam1.focBeamS.wavefunction(x, y, z);
[eplus1d; eplus1p; eplus1s]

%% each field
%inside sphere field has been just listed below to test program. The line is completely
%outside the sphere in this file.

rstart=[-2,0.3,0.7];rstop=[2,0.3,0.7];
rstart=rstart-r_sph;rstop=rstop-r_sph;
figure;
[data, fig]=totalBeam1.focBeamS.lineCut(rstart,rstop,50,'ExR');
figure;
[data, fig]=totalBeam1.scatBeampq.lineCut(rstart,rstop,50,'ExR');
figure;
[data, fig]=totalBeam1.scatBeamcd.lineCut(rstart,rstop,50,'ExR');

% Nx=50;
% xx=linspace(-2,2,Nx+1);yy=zeros(1,Nx+1);
% for ii=1:Nx+1
%     x=xx(ii);y=0.3;z=0.7;
%     x=x-r_sph(1);y=y-r_sph(2);z=z-r_sph(3);
% [eplus1p, hplus1p]=totalBeam1.focBeamS.wavefunction(x, y, z);
% yy(ii)=real(eplus1p(1));
% [eplus1p, hplus1p]=totalBeam1.scatBeampq.wavefunction(x, y, z);
% yy(ii)=yy(ii)+real(eplus1p(1));
% end
% figure;plot(xx,yy)
% hold on;
% [data, fig]=totalBeam1.allBeam.lineCut(rstart,rstop,50,'ExR');
%% Line compare
data1=dlmread('D:\mywork\zhoulm\OpticalTrap\FScat\SphereScat\SphereScat\calibration1\03fld_all1.txt');
figure;
[data, fig]=totalBeam1.allBeam.lineCut(rstart,rstop,50,'ExR');
hold on;
plot(data1(:,1),data1(:,4),'b--','Linewidth',2)
figure;
[data, fig]=lg1.lineCut([-2,0.3,0.7],[2,0.3,0.7],50,'EyR');
hold on;
plot(data1(:,1),data1(:,5),'b--','Linewidth',2)

figure;
[data, fig]=lg1.lineCut([-2,0.3,0.7],[2,0.3,0.7],50,'EzR');
hold on;
plot(data1(:,1),data1(:,6),'b--','Linewidth',2)

figure;
[data, fig]=lg1.lineCut([-2,0.3,0.7],[2,0.3,0.7],50,'Ea');
hold on;
plot(data1(:,1),data1(:,7),'b--','Linewidth',2)

%% use the ott function get the same result
r=[x,y,z];
Fldtmp=ott13.electromagnetic_field_xyz(r/wavelength,[n;m],[a2;b2],[],[]);
eplus1ott=Fldtmp.Eincident*lg1.focBeam.AmplitudeFactor;
[eplus1d; eplus1p; eplus1s;eplus1ott]





%% This is an example of calculate field inside sphere with Lin
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
r_sph=[0.5,0.2,0.1];%r_sph=[0,0,2];%test result:x=0 will OK,others not.
radius =0.5;%unit um
scatter_medium='silica';
scat1=model.phy.PhysicalObject.Scatterer.SphereScatter(r_sph,radius,scatter_medium);

k=lg1.focBeam.k;
n_relative=scat1.scatter_medium.n/len.work_medium.n; %The relative unit is the wavelength in working medium of len.
Nmax=ott13.ka2nmax(k*scat1.radius);Nmax=Nmax*5;Nmax=15;
lg1.getVSWFcoeff(Nmax);

%%calculation
%get ab and T matrix.
a0=lg1.focBeam.aNNZ(:,3);
b0=lg1.focBeam.bNNZ(:,3);
n0=lg1.focBeam.aNNZ(:,1);
m0=lg1.focBeam.aNNZ(:,2);
[a1,b1,n1,m1]=abLin2Nie(a0,b0,n0,m0);
[a,b,n,m] = ott13.make_beam_vector(a1,b1,n1,m1);

[T, T2] = tmatrix_sphere(Nmax,k,k*n_relative,scat1.radius);

[rt,theta,phi]=ott13.xyz2rtp(scat1.x,scat1.y,scat1.z);

R = ott13.z_rotation_matrix(theta,phi); %calculates an appropriate axis rotation off z.
D = wignerD(Nmax,R');

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

tmp=[totalBeam1.focBeamS.aNNZ,totalBeam1.focBeamS.bNNZ(:,3)];tmp=full(tmp);
% tmp=[n0,m0,a0,b0];tmp=full(tmp);
% tmp=[n,m,a2,b2];tmp=full(tmp)
%% compare single point
x=0.6; y=0.3; z=0.2;
x=x-r_sph(1);y=y-r_sph(2);z=z-r_sph(3);
[eplus1s, hplus1s]=totalBeam1.scatBeamcd.wavefunction(x, y, z);
r=[x,y,z];
% Fldtmp=ott13.electromagnetic_field_xyz(r/wavelength,[n;m],[a2;b2],[],[]);
Fldtmp=ott13.electromagnetic_field_xyz(r/wavelength,[n;m],[a2;b2],[p;q],[c;d],n_relative);
eplus1ott=Fldtmp.Einternal*lg1.focBeam.AmplitudeFactor;
[eplus1s;eplus1ott]
[abs(eplus1ott(1))/abs( eplus1s(1)),abs(eplus1ott(2))/abs( eplus1s(2))]

%% Line compare
data1=dlmread('D:\mywork\zhoulm\OpticalTrap\FScat\SphereScat\SphereScat\calibration1\03fld_all3_insidesphere.txt');
rstart0=[-2,0.3,0.2];rstop0=[2,0.3,0.2];
rstart=rstart0-r_sph;rstop=rstop0-r_sph;
figure;
data=totalBeam1.scatBeamcd.lineCut(rstart,rstop,50,'ExR');
plot(r_sph(1)+data(:,1), real(data(:,4)), 'r-');
hold on;
plot(data1(:,1),data1(:,4),'b--','Linewidth',2)

%% figure;
data=totalBeam1.scatBeamcd.lineCut(rstart,rstop,50,'EyR');
plot(r_sph(1)+data(:,1), real(data(:,5)), 'r-');
hold on;
plot(data1(:,1),data1(:,5),'b--','Linewidth',2)

figure;
data=totalBeam1.scatBeamcd.lineCut(rstart,rstop,50,'EzR');
plot(r_sph(1)+data(:,1), real(data(:,6)), 'r-');
hold on;
plot(data1(:,1),data1(:,6),'b--','Linewidth',2)

figure;
plot(data1(:,1),1e4*(real(data(:,6))-data1(:,6)))

% figure;
% data=totalBeam1.focBeamS.lineCut(rstart,rstop,50,'Ea');
% datapq=totalBeam1.scatBeampq.lineCut(rstart,rstop,50,'Ea');
% plot(r_sph(1)+data(:,1), real(data(:,4)+datapq(:,)), 'r-');
% hold on;
% plot(data1(:,1),data1(:,7),'b--','Linewidth',2)







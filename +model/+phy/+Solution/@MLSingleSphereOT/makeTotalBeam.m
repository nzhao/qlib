function total_beam = makeTotalBeam ( obj, scatterer,focal_beam, Tab,Tcd,Tfg)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

import model.phy.PhysicalObject.LaserBeam.totalBeam

Nmax=obj.parameters.CutOffNMax;
wavelength=obj.parameters.IncBeamWaveLength;%should be wavlenth in working_medium of lens?

a0=focal_beam.focBeam.aNNZ(:,3);
b0=focal_beam.focBeam.bNNZ(:,3);
n0=focal_beam.focBeam.aNNZ(:,1);
m0=focal_beam.focBeam.aNNZ(:,2);
% [a1,b1,n1,m1]=abLin2Nie(a0,b0,n0,m0);
%abLin2Nie function transform the [a0,b0] in Lin's note to Nieminen's.
pre=sqrt(4*pi);
a1=(1i).^(n0-1)*pre.*b0;
b1=(1i).^(n0-1)*pre.*a0;
n1=n0;m1=m0;
[a,b,n,m] = ott13.make_beam_vector(a1,b1,n1,m1);
%root power for nomalization to a and b individually.
pwr = sqrt(sum( abs(a).^2 + abs(b).^2 ));
% %normalize total momentum of wave sum to 1. Not good for SI EM field.
% a=a/pwr;
% b=b/pwr;
%transform the partial wave coefficents to the sphere frame.
[rt,theta,phi]=ott13.xyz2rtp(scatterer.x,scatterer.y,scatterer.z);
R = ott13.z_rotation_matrix(theta,phi); %calculates an appropriate axis rotation off z.
D = wignerD(Nmax,R');
[A,B] = ott13.translate_z(Nmax,rt/wavelength);
a2 = D'*(  A * D*a +  B * D*b ); % Wigner matricies here are hermitian. Therefore in MATLAB the D' operator is the inverse of D.
b2 = D'*(  A * D*b +  B * D*a ); % In MATLAB operations on vectors are done first, therefore less calculation is done on the matricies.
%% calculate the scattering coefficents
pq = Tab * [ a2; b2 ];
p = pq(1:length(pq)/2);
q = pq(length(pq)/2+1:end);%It's noticed that [a2,b2,p,q] are incident-scatter beam formula at sphere center.

[M,N]=size(Tcd);M=M/2;
cc=zeros(M,N);dd=zeros(M,N);ff=zeros(M,N);gg=zeros(M,N);
for jj=1:N
cd = Tcd(:,:,jj) * [ a2; b2 ];
cc(:,jj) = cd(1:length(cd)/2);
dd(:,jj) = cd(length(cd)/2+1:end);
fg = Tfg(:,:,jj) * [ a2; b2 ];
ff(:,jj) = fg(1:length(fg)/2);
gg(:,jj) = fg(length(fg)/2+1:end);
end
% make the totalbeam
total_beam=TotalBeamML(n,m,a2,b2,p,q,cc,dd,ff,gg,scatterer,focal_beam);
end


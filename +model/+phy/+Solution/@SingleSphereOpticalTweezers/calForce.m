function [force, torque] = calForce(obj, total_beam)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% pwr = sqrt(sum( abs(a).^2 + abs(b).^2 ));
tmp=total_beam.nmabpqcd;
n=tmp(:,1);m=tmp(:,2);a2=tmp(:,3);b2=tmp(:,4);
p=tmp(:,5);q=tmp(:,6);c=tmp(:,7);d=tmp(:,8);
pwr = sqrt(sum( abs(a2).^2 + abs(b2).^2 ));
% [rt,theta,phi]=ott13.xyz2rtp(scatterer.x,scatterer.y,scatterer.z);

%Fz
fz = ott13.force_z(n,m,a2,b2,p,q);
fz=fz/pwr^2;
%Fx
% Rx = ott13.z_rotation_matrix(pi/2,0);
% % Dx = ott13.wigner_rotation_matrix(Nmax,Rx);
% Dx = wignerD(Nmax,Rx');    
%     fr(nr) = ott13.force_z(n,m,Dx*a2,Dx*b2,Dx*p,Dx*q); %Dx makes the z-force calculation the x-force calculation.
force=fz;
torque=0;
end


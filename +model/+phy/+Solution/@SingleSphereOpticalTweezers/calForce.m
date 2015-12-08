function [force, torque] = calForce(obj, n,m,a2,b2,p,q, pwr)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% pwr = sqrt(sum( abs(a).^2 + abs(b).^2 ));
% [n,m,a2,b2,p,q]=[total_beam.focBeamS.aNNZ,total_beam.focBeamS.bNNZ(:,3),total_beam.focBeamS.aNNZ];
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


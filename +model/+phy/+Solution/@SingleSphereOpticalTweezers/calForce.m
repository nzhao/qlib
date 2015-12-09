function [force, torque] = calForce(obj, total_beam, focalPower)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

Nmax=obj.parameters.CutOffNMax;
tmp=total_beam.nmabpqcd;
n=tmp(:,1);m=tmp(:,2);a2=tmp(:,3);b2=tmp(:,4);
p=tmp(:,5);q=tmp(:,6);%c=tmp(:,7);d=tmp(:,8);
pwr = sqrt(sum( abs(a2).^2 + abs(b2).^2 ));%pwr2=pwr
%normalizing to pwr(a2,b2) is slight different from normalizing to
%pwr(a,b) in Lin, which can be neglected.
%Fz
fz = ott13.force_z(n,m,a2,b2,p,q);
fqz=fz/pwr^2;
%Fx
Rx = ott13.z_rotation_matrix(pi/2,0);
Dx = wignerD(Nmax,Rx');
fx = ott13.force_z(n,m,Dx*a2,Dx*b2,Dx*p,Dx*q); %Dx makes the z-force calculation the x-force calculation.
fqx=fx/pwr^2;
%Fy
Ry = ott13.z_rotation_matrix(pi/2,pi/2);
Dy = wignerD(Nmax,Ry');
fy = ott13.force_z(n,m,Dy*a2,Dy*b2,Dy*p,Dy*q); %Dx makes the z-force calculation the x-force calculation.
fqy=fy/pwr^2;
force=[fqx,fqy,fqz];
% force=[fx,fy,fz];

torque=[0,0,0];

if nargin>2
    force=focalPower*force;
    torque=focalPower*torque;
end
    
end


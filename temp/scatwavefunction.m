function [eField, hField] = scatwavefunction(r,r0, n2, m2, a2, b2,objf,objs )
%scattedwavefunction Summary of this function goes here
%   Detailed explanation goes here
%   objf is the an object of FocBeam, objs is an object of Spherescatter.
% as it's changed from lg1.focBeam.wavefunction,it would be better be an formal
% function.
import model.phy.PhysicalObject.LaserBeam.assist.gammaMN
import model.math.misc.Cart2Sph

eField=zeros(1, 3); hField=zeros(1, 3);
r=r-r0;
flag=(norm(r)>objs.radius);
if flag %field outside sphere
x=r(1);y=r(2);z=r(3);
[r, theta, phi]=Cart2Sph(x, y, z);
kr=objf.k*r;
if kr==0
    kr=eps;
end

Z=objf.medium.Z;
for kk=1:length(a2)
    n=n2(kk); m=m2(kk); amn=a2(kk);    
    prefact = (1.j)^(n-1)* sqrt(4.0*pi);% See Doc: VSWF.m
    [M_mode, N_mode] = ott13.vswfcart(n,m,kr,theta,phi,3);
    eField=eField+ amn* prefact *N_mode;
    hField=hField+ amn* prefact *M_mode / (1.j*Z);
end

for kk=1:length(b2)
    n=n2(kk); m=m2(kk); bmn=b2(kk);
    prefact = (1.j)^(n-1)* sqrt(4.0*pi);% See Doc: VSWF.m
    [M_mode,N_mode] = ott13.vswfcart(n,m,kr,theta,phi,3);
    eField=eField+ bmn* prefact *M_mode;
    hField=hField+ bmn* prefact *N_mode / (1.j*Z);
end
eField=eField*objf.AmplitudeFactor;
hField=hField*objf.AmplitudeFactor;
else
    disp('inside the sphere on going.');
end



end


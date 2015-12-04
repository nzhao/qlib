function [efield, hfield,efieldinc, hfieldinc,efieldscat, hfieldscat]=totalfield(r,totalBeam1,scat1)
%This function output the total field after scattering
%
radius=scat1.radius;
r_sph=[scat1.x,scat1.y,scat1.z];
r12=r-r_sph;
x=r12(1);y=r12(2);z=r12(3);

if norm(r12)>=radius
    [efieldinc, hfieldinc]=totalBeam1.focBeamS.wavefunction(x, y, z);
    [efieldscat, hfieldscat]=totalBeam1.scatBeampq.wavefunction(x, y, z);
    efield=efieldinc+efieldscat;
    hfield=hfieldinc+hfieldscat;    
else
    efieldinc=[0,0,0]; hfieldinc=[0,0,0];
    efieldscat=[0,0,0]; hfieldscat=[0,0,0];
    [efield, hfield]=totalBeam1.scatBeamcd.wavefunction(x, y, z);
end
end

classdef TotalBeamML < model.phy.PhysicalObject.LaserBeam.OpticalField
    %TOTALBEAMML Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        focBeamS;%focused incident beam in the sphere frame:a2,b2
        scatBeampq;%pq
        scatBeamccdd;%beam inside the sphere:cd
        scatBeamffgg;%beam inside the sphere:fg
        nmabpqcd;%store the pure coefficents in OTT convention for force and torque calculation.
        scatterer;
        
    end
    
    methods
        function obj=TotalBeamML(n,m,a2,b2,p,q,cc,dd,ff,gg,scat1,lg1)
            obj.nmabpqcd=[n,m,a2,b2,p,q,cc,dd,ff,gg];
            obj.scatterer=scat1;
            medium2=lg1.lens.work_medium;
            wavelength2=lg1.incBeam.wavelength/medium2.n;
            
            %focBeamS
            obj.focBeamS=model.phy.PhysicalObject.LaserBeam.LaserBeamPartialWave(...
                'FocusedFieldInSphereFrame',wavelength2, medium2.name);
            [ n1t,m1t,a1t,b1t ] = flatab2ab( n,m,a2,b2 );[a0t,b0t,n0t,m0t]=abNie2Lin(a1t,b1t,n1t,m1t);
            obj.focBeamS.aNNZ=[n0t,m0t,a0t];obj.focBeamS.bNNZ=[n0t,m0t,b0t];
            obj.focBeamS.AmplitudeFactor=lg1.AmplitudeFactor;
            %another property 'amplitude' in not updated now, attention later.
            %scatBeampq
            obj.scatBeampq=model.phy.PhysicalObject.LaserBeam.LaserBeamPartialWave(...
                'scatFieldOutsideSphere',wavelength2, medium2.name);
            [ n1t,m1t,a1t,b1t ] = flatab2ab( n,m,p,q );[a0t,b0t,n0t,m0t]=abNie2Lin(a1t,b1t,n1t,m1t);
            obj.scatBeampq.aNNZ=[n0t,m0t,a0t];obj.scatBeampq.bNNZ=[n0t,m0t,b0t];
            obj.scatBeampq.AmplitudeFactor=lg1.AmplitudeFactor;
            obj.scatBeampq.beamtype=1;
            
            %scatBeamcdfg
            [~,N]=size(cc);
            obj.scatBeamccdd=[];obj.scatBeamffgg=[];
            for jj=1:N
                
                medium2=scat1.scatter_medium{jj};
                wavelength2=lg1.incBeam.wavelength/medium2.n;
                
                scatBeamcd=model.phy.PhysicalObject.LaserBeam.LaserBeamPartialWave(...
                    'scatFieldInSphere',wavelength2, medium2.name);%%cd
                [ n1t,m1t,a1t,b1t ] = flatab2ab( n,m,cc(:,jj),dd(:,jj) );
                [a0t,b0t,n0t,m0t]=abNie2Lin(a1t,b1t,n1t,m1t);
                scatBeamcd.aNNZ=[n0t,m0t,a0t];scatBeamcd.bNNZ=[n0t,m0t,b0t];
                scatBeamcd.AmplitudeFactor=lg1.AmplitudeFactor;
                scatBeamcd.beamtype=3;
                obj.scatBeamccdd=[obj.scatBeamccdd,scatBeamcd];
                
                scatBeamfg=model.phy.PhysicalObject.LaserBeam.LaserBeamPartialWave(...
                    'scatFieldInSphere',wavelength2, medium2.name);%%fg
                [ n1t,m1t,a1t,b1t ] = flatab2ab( n,m,ff(:,jj),gg(:,jj) );
                [a0t,b0t,n0t,m0t]=abNie2Lin(a1t,b1t,n1t,m1t);
                scatBeamfg.aNNZ=[n0t,m0t,a0t];scatBeamfg.bNNZ=[n0t,m0t,b0t];
                scatBeamfg.AmplitudeFactor=lg1.AmplitudeFactor;
                scatBeamfg.beamtype=4;
                obj.scatBeamffgg=[obj.scatBeamffgg,scatBeamfg];
            end
            
        end
        
        function [efield, hfield,efieldinc, hfieldinc,efieldscat, hfieldscat]=wavefunction(obj,x,y,z)
            %This function output the total field after scattering
            %
            sphere=obj.scatterer;
            radius=sphere.radius;N=length(radius);
            r_sph=[sphere.x,sphere.y,sphere.z];
            r=[x,y,z];
            r12=r-r_sph;
            x=r12(1);y=r12(2);z=r12(3);
                        
            if norm(r12)>=radius(N)
                [efieldinc, hfieldinc]=obj.focBeamS.wavefunction(x, y, z);
                [efieldscat, hfieldscat]=obj.scatBeampq.wavefunction(x, y, z);
                efield=efieldinc+efieldscat;   hfield=hfieldinc+hfieldscat;
            else
                tmp=find(~(norm(r12)>radius));jj=tmp(1);
%                 tmpBeam=obj.scatBeamccdd;tmpBeam(jj)
                scatBeamcd=obj.scatBeamccdd(jj);
                scatBeamfg=obj.scatBeamffgg(jj);                
                efieldinc=[0,0,0]; hfieldinc=[0,0,0];
                efieldscat=[0,0,0]; hfieldscat=[0,0,0];
                [efieldcd, hfieldcd]=scatBeamcd.wavefunction(x, y, z);
                [efieldfg, hfieldfg]=scatBeamfg.wavefunction(x, y, z);
                efield=efieldcd+efieldfg;    hfield=hfieldcd+hfieldfg;
            end
        end
        
    end
    
end

%local function of totalBeam
function [ n,m,a,b ] = flatab2ab( n,m,a,b )
%FLATAB2AB Summary of this function goes here
%   Flatab2ab transform ab to original ab form.
ai=find(a);
n=n(ai);
m=m(ai);
a=a(ai);
b=b(ai);
end

function [a0,b0,n,m]=abNie2Lin(a1,b1,n1,m1)
%
%abNie2Lin function transform the [a0,b0] in Nieminen's to Lin's note.
N=length(a1);
a0=zeros(N,1);b0=zeros(N,1);
pre=1.0/sqrt(4*pi);
for ii=1:N
    a0(ii)=(1i)^(1-n1(ii))*pre*b1(ii);
    b0(ii)=(1i)^(1-n1(ii))*pre*a1(ii);
end
n=n1;m=m1;
end

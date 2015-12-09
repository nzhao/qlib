classdef totalBeam < model.phy.PhysicalObject.PhysicalObject
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    % It is noticed that fobBeamS,scatBeampq,scatBeamcd are stored for
    % field calculation. Since they use the the same abNie2Lin.m functon
    % the {pq,cd} differs from Lin with order or coeffcients, though the
    % field is right.
    
    properties
        focBeamS;%focused incident beam in the sphere frame:a2,b2
        scatBeampq;%pq
%         allBeam;%all beam outside sphere:a2b2+pq
        scatBeamcd;%beam inside the sphere:cd
        nmabpqcd;%store the pure coefficents in OTT convention for force and torque calculation.
        
    end
    
    methods
        function obj=totalBeam(n,m,a2,b2,p,q,c,d,scat1,lg1)
            obj.nmabpqcd=[n,m,a2,b2,p,q,c,d];
            medium2=lg1.lens.work_medium;
            wavelength2=lg1.incBeam.wavelength/medium2.n;
            %focBeamS
            obj.focBeamS=model.phy.PhysicalObject.LaserBeam.LaserBeamPartialWave(...
                'FocusedFieldInSphereFrame',wavelength2, medium2.name);
            [ n1t,m1t,a1t,b1t ] = flatab2ab( n,m,a2,b2 );[a0t,b0t,n0t,m0t]=abNie2Lin(a1t,b1t,n1t,m1t);
            obj.focBeamS.aNNZ=[n0t,m0t,a0t];obj.focBeamS.bNNZ=[n0t,m0t,b0t];
            obj.focBeamS.AmplitudeFactor=lg1.AmplitudeFactor;%another property 'amplitude' in not updated now, attention later.
            %scatBeampq
            obj.scatBeampq=model.phy.PhysicalObject.LaserBeam.LaserBeamPartialWave(...
                'scatFieldOutsideSphere',wavelength2, medium2.name);
            [ n1t,m1t,a1t,b1t ] = flatab2ab( n,m,p,q );[a0t,b0t,n0t,m0t]=abNie2Lin(a1t,b1t,n1t,m1t);
            obj.scatBeampq.aNNZ=[n0t,m0t,a0t];obj.scatBeampq.bNNZ=[n0t,m0t,b0t];
            obj.scatBeampq.AmplitudeFactor=lg1.AmplitudeFactor;
            obj.scatBeampq.beamtype=1;
%             %allBeam
%             obj.allBeam=model.phy.PhysicalObject.LaserBeam.LaserBeamPartialWave(...
%                 'allFieldOutsideSphere',wavelength2, medium2.name);
%             [ n1t,m1t,a1t,b1t ] = flatab2ab( n,m,a2+p,b2+q );[a0t,b0t,n0t,m0t]=abNie2Lin(a1t,b1t,n1t,m1t);
%             obj.allBeam.aNNZ=[n0t,m0t,a0t];obj.allBeam.bNNZ=[n0t,m0t,b0t];
%             obj.allBeam.AmplitudeFactor=lg1.AmplitudeFactor;
%             obj.allBeam.beamtype=1;
            %scatBeamcd
            medium2=scat1.scatter_medium;
            wavelength2=lg1.incBeam.wavelength/medium2.n;            
            obj.scatBeamcd=model.phy.PhysicalObject.LaserBeam.LaserBeamPartialWave(...
                'scatFieldInSphere',wavelength2, medium2.name);
            [ n1t,m1t,a1t,b1t ] = flatab2ab( n,m,c,d );[a0t,b0t,n0t,m0t]=abNie2Lin(a1t,b1t,n1t,m1t);
            obj.scatBeamcd.aNNZ=[n0t,m0t,a0t];obj.scatBeamcd.bNNZ=[n0t,m0t,b0t];
            obj.scatBeamcd.AmplitudeFactor=lg1.AmplitudeFactor;
            
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



%Now we try to calculate the case of core-shell sphere.
import model.phy.Solution.MLSingleSphereOT
import model.phy.PhysicalObject.LaserBeam.totalBeam
sol=MLSingleSphereOT('OpticalTweezers.xml');
force=sol.perform()
%% single point compare
[efield, hfield,efieldinc, hfieldinc,efieldscat, hfieldscat]...
    =sol.result.total_beam.wavefunction(0.6,0.3,0.2)
[efield, hfield,efieldinc, hfieldinc,efieldscat, hfieldscat]...
    =sol.result.total_beam.wavefunction(0.5,0.2,0.7)

%% Line compare
data1=dlmread('03fld_all.txt');
rstart=[-0.5,0.25,0.15];rstop=[1.5,0.25,0.15];

figure;
data=sol.result.total_beam.lineCut(rstart,rstop,50,'ExR');
plot(data(:,1), real(data(:,4)), 'r-');
hold on;
plot(data1(:,1),data1(:,4),'b--','Linewidth',2)

figure;
data=sol.result.total_beam.lineCut(rstart,rstop,50,'EyR');
plot(data(:,1), real(data(:,5)), 'r-');
hold on;
plot(data1(:,1),data1(:,5),'b--','Linewidth',2)

figure;
[data,fig]=sol.result.total_beam.lineCut(rstart,rstop,50,'EzR');
hold on;
plot(data1(:,1),data1(:,6),'b--','Linewidth',2)

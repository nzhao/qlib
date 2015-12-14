function [T, T2] = getTmatrix( obj, scatterer)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%
%The relative length unit is the wavelength in working medium of lens.
work_medium =model.phy.data.MediumData.get_parameters(obj.parameters.WorkingMedium);
n=work_medium.n;
k=n*2*pi/obj.parameters.IncBeamWaveLength;
N=length(scatterer.scatter_medium);
n_relative=zeros(1,N);
for ii=1:N
n_relative(ii)=scatterer.scatter_medium(ii).n/n;
Nmax=obj.parameters.CutOffNMax;

[T, T2] = ott13.tmatrix_mie(Nmax,k,k*n_relative,scatterer.radius);
T2=-T2;% OTT added a minus '-', so add another to cancel it here.

end


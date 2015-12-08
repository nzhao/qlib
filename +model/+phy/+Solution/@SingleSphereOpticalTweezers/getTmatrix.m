function [T, T2] = getTmatrix( obj, focal_beam, scatterer)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
k=focal_beam.focBeam.k;
%n_relative=scatterer.scatter_medium.n/len.work_medium.n;
%The relative unit is the wavelength in working medium of lens.
n_relative=scatterer.scatter_medium.n/focal_beam.focBeam.medium.n;
Nmax=obj.parameters.CutOffNMax;

[T, T2] = ott13.tmatrix_mie(Nmax,k,k*n_relative,scatterer.radius);
T2=-T2;


end


function [Tab, Tcd, Tfg] = getTmatrix( obj, scatterer)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%
%The relative length unit is the wavelength in working medium of lens.
work_medium =model.phy.data.MediumData.get_parameters(obj.parameters.WorkingMedium);
n=work_medium.n;
k=n*2*pi/obj.parameters.IncBeamWaveLength;
N=length(scatterer.radius);
n_relative=zeros(1,N);
for ii=1:N
    medium_tmp=scatterer.scatter_medium{ii};
    n_relative(ii)=medium_tmp.n;
%     n_relative(ii)=scatterer.scatter_medium_n(ii)/n;
end
Nmax=obj.parameters.CutOffNMax;

[Tab, Tcd, Tfg] = tmatrix_MLSphere(Nmax,k,k*n_relative,scatterer.radius);

end


function [T, T2, a, b] = getTmatrix( obj )
%GETTMATRIX Summary of this function goes here
%   Detailed explanation goes here
    nmax=obj.Nmax;
    kVacuum=obj.incBeam.k;
    bg_medium=obj.lens.inc_medium.name;
    [T, T2, a, b] = obj.sphere.tMatrix(nmax, kVacuum, bg_medium);
end


function [ x, y, z ] = Cylind2Cart( r, theta, phi )
%CY Summary of this function goes here
%   Detailed explanation goes here
x=r*sin(theta)*cos(phi);
y=r*sin(theta)*sin(phi);
z=r*cos(theta);
end


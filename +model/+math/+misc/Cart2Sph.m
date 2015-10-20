function [ r, theta, phi ] = Cart2Sph( x, y, z )
%CART2SPH Summary of this function goes here
%   Detailed explanation goes here
    r = sqrt(x*x +  y*y + z*z);

    if r==0
        theta=0; phi=0;
    else
        theta = acos(z/r);
        [ ~, phi, ~ ] = model.math.misc.Cart2Cylind( x, y, 1.0 );
    end

end


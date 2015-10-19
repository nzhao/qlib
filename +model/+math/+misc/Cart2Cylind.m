function [ r, phi, z ] = Cart2Cylind( x, y, z1 )
%CART2CYLIND Summary of this function goes here
%   Detailed explanation goes here
r=sqrt(x*x+y*y);
if x > 0
    phi=atan(y/x);
elseif x<0 && y>0
    phi=pi+atan(y/x);
elseif x<0 && y<=0
    phi= -pi+atan(y/x);
elseif x==0 && y>0
    phi= 0.5*pi;
else %x==0 && y<0
    phi= -0.5*pi;
end

z=z1;

end


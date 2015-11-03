function [a,b,n,m] = getBSC( obj )
%GET_BSC Summary of this function goes here
%   Detailed explanation goes here
    a00=obj.beam.focBeam.aNNZ(:,3);
    b00=obj.beam.focBeam.bNNZ(:,3);
    n  =obj.beam.focBeam.aNNZ(:,1);
    m  =obj.beam.focBeam.aNNZ(:,2);
    
    prefactor=sqrt(4*pi) * (1i).^(n-1);
    a0=prefactor.*b00; %swap a, b
    b0=prefactor.*a00;
    
    [a,b,n,m] = ott13.make_beam_vector(a0,b0,n,m);
    
    pwr = sqrt(sum( abs(a).^2 + abs(b).^2 ));
    a=a/pwr; b=b/pwr;
end


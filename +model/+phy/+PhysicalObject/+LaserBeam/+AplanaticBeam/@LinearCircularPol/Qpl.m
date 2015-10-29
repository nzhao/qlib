function [Qa,Q1a,Q2a] = Qpl( obj, p, l, sinA, cosA )
%QPL Summary of this function goes here
%   Detailed explanation goes here
    n1=obj.lens.inc_medium.n;
    n2=obj.lens.work_medium.n;
    
    y=sqrt(2.0)*n2*sinA/obj.f0/obj.lens.NA;
    Pa=y.^abs(l) .* laguerreL(p, abs(l), y.*y);
    Qa=sqrt(n1/n2)*Pa.*exp(-0.5*y.*y).*sinA.*sqrt(cosA);
    Z=377.0/n2;% The wave impedance of working miudm.
    Q1a=1/Z*n1/n2*Pa.^2.*exp(-y.*y).*(1+cosA).^2.*sinA;
    Q2a=1/Z*n1/n2*Pa.^2.*exp(-y.*y).*(1-cosA).^2.*sinA;
end
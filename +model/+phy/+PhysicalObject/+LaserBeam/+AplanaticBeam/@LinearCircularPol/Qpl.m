function Qa = Qpl( obj, p, l, sinA, cosA )
%QPL Summary of this function goes here
%   Detailed explanation goes here
    n1=obj.lens.inc_medium.n;
    n2=obj.lens.work_medium.n;
    
    y=sqrt(2.0)*n2*sinA/obj.f0/obj.lens.NA;
    Pa=y.^abs(l) .* laguerreL(p, abs(l), y.*y);
    Qa=sqrt(n1/n2)*Pa.*exp(-0.5*y.*y).*sinA.*sqrt(cosA);
end


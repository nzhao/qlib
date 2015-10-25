function Qa = Qpl( obj, p, l, sinA, cosA )
%QPL Summary of this function goes here
%   Detailed explanation goes here
    y=sqrt(2.0)*obj.nMedium*sinA/obj.f0/obj.na;
    Pa=y.^abs(l) .* laguerreL(p, abs(l), y.*y);
    Qa=sqrt(obj.n0/obj.nMedium)*Pa.*exp(-0.5*y.*y).*sinA.*sqrt(cosA);
end


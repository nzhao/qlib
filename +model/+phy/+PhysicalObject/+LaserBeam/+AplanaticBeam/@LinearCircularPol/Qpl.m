function Qa = Qpl( obj, p, l, sinA, cosA )
%QPL Summary of this function goes here
%   Detailed explanation goes here
        y=sqrt(2.0)*obj.n2*sinA/obj.f0/obj.na;
        Pa=y.^l .* laguerreL(p, l, y.*y);
        Qa=Pa.*exp(-0.5*y.*y).*sinA.*sqrt(cosA);
end


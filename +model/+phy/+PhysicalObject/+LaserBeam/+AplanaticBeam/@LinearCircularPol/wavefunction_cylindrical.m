function val = wavefunction_cylindrical( obj, rho, phi, z )
%WAVEFUNCTION_CYLINDRICAL Summary of this function goes here
%   Detailed explanation goes here
    kz=obj.incBeam.k*z;
    kr=obj.incBeam.k*rho;
    px=obj.incBeam.px; py=obj.incBeam.py; %#ok<*PROP>

    nPiece=ceil(max([kz, kr, 1]));
    [aList, wList]=obj.alpha_sampling(nPiece);

    sinA=sin(aList); cosA=cos(aList); 
    sinA2=0.5-0.5*cosA; cosA2=0.5+0.5*cosA;  %sin^2(a/2) and cos^2(a/2)

    exp_kz=exp(1.j*kz*cosA);

    x=kr*sinA;  l=abs(obj.incBeam.l);
    f1=besselj(l-2, x).*sinA2;
    f2=besselj(l+2, x).*sinA2;
    f3=besselj(l, x).*cosA2;
    f4=besselj(l-1, x).*sinA;
    f5=besselj(l+1, x).*sinA;
    
    Qa=obj.Qpl(obj.incBeam.p, obj.incBeam.l, sinA, cosA);

    e1phi=exp(1.j*phi); e2phi=e1phi*e1phi; elphi=(1.j*e1phi)^l;
    e1phi1=e1phi'; e2phi1=e2phi';
    pp=px+1.j*py; pm=px-1.j*py;

    ex=Qa.*exp_kz.*(pp*e2phi1.*f1 + pm*e2phi.*f2 + 2.0*px*f3) * 0.5*elphi;
    ey=Qa.*exp_kz.*(pp*e2phi1.*f1 - pm*e2phi.*f2 - 2.0*py*f3) * 0.5*1.j*elphi;
    ez=Qa.*exp_kz.*(pp*e1phi1.*f4 - pm*e1phi.*f5 )            * 0.5*1.j*elphi;

    Z=obj.lens.work_medium.Z;
    hx=  Qa.*exp_kz.*(pp*e2phi1.*f1 - pm*e2phi.*f2 + 2.0*1.j*py*f3) * 0.5*1.j*elphi/Z;
    hy= -Qa.*exp_kz.*(pp*e2phi1.*f1 + pm*e2phi.*f2 - 2.0*px*f3)     * 0.5*elphi/Z;
    hz= -Qa.*exp_kz.*(pp*e1phi1.*f4 + pm*e1phi.*f5 )                * 0.5*elphi/Z;

    val=([ex; ey; ez; hx; hy; hz]*wList')*obj.unitFactor();
end
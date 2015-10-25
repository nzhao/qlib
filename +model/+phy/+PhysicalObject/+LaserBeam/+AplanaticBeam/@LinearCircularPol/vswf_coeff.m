function [ pmn, qmn ] = vswf_coeff( obj, m, n, Qa, cosA, wList )
%VSWF_COEFF Summary of this function goes here
%   Detailed explanation goes here
    if m~=obj.l+1 && m~=obj.l-1
        pmn=0.0; qmn=0.0;
    else
        import model.phy.PhysicalObject.LaserBeam.assist.gammaMN
        import model.phy.PhysicalObject.LaserBeam.assist.pi_tauMN
        
        prefactor=0.5*sqrt(obj.n0/obj.nMedium)*sqrt( gammaMN(m,n) );
        [pi_mn, tau_mn]=pi_tauMN(m, n, cosA);
        
        if m==obj.l+1
            pmn = prefactor*( obj.px-1.j*obj.py)*sum(wList.*Qa.*(pi_mn+tau_mn));
            qmn = pmn;
        else %m==obj.l-1
            pmn = prefactor*(-obj.px-1.j*obj.py)*sum(wList.*Qa.*(pi_mn-tau_mn));
            qmn = -pmn;
        end


    end

end


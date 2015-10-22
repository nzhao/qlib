function [eField, hField] = field(obj, x, y, z)
%FIED Summary of this function goes here
%   Detailed explanation goes here
    import model.phy.PhysicalObject.LaserBeam.assist.gammaMN
    import model.math.misc.Cart2Sph
    
    eField=zeros(1, 3); hField=zeros(1, 3);
    [r, theta, phi]=Cart2Sph(x, y, z);
    kr=obj.k*r;
    if kr==0
        kr=eps;
    end
    
    for kk=1:length(obj.aNNZ)
        aTerm=obj.aNNZ(kk,:);
        n=aTerm(1); m=aTerm(2); amn=aTerm(3);
        
        prefact = (1.j)^n;% * sqrt(gammaMN(m, n));
        [M_mode, N_mode] = ott13.vswfcart(n,m,kr,theta,phi,3);
        eField=eField+ (-1.j)* amn* prefact * sqrt(4.0*pi)*N_mode;
        hField=hField+ amn* prefact * sqrt(4.0*pi)*M_mode;
    end

    for kk=1:length(obj.bNNZ)
        bTerm=obj.bNNZ(kk,:);
        n=bTerm(1);  m=bTerm(2); bmn=bTerm(3);
        prefact = (1.j)^n;% * sqrt(gammaMN(m, n));
        [M_mode,~] = ott13.vswfcart(n,m,kr,theta,phi,3);
        eField=eField+ (-1.j)* bmn* prefact * sqrt(4.0*pi)*M_mode;
        hField=hField+ bmn* prefact * sqrt(4.0*pi)*N_mode;
    end
    
end


function lgdMN = legendrePmn( m, n, cosA )
%LEGENDREPMN Summary of this function goes here
%   Detailed explanation goes here
    lgd=legendre(n, cosA);
    
    if m >=0
        lgdMN=lgd(m+1,:);
    else %m<0
        % P_n^(-m1)=(-1)^m1 * (n-m1)! / (n+m1)! P_n^m1, for m1>0, see Eq.(37)
        m1=-m;
        fact=factorial(n-m1) / factorial(n+m1);
        lgdMN=(-1.0)^m1 * fact *lgd(m1+1,:);
    end

end


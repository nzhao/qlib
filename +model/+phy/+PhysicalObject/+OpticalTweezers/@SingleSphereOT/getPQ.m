function [ p, q, a2, b2 ] = getPQ( obj, rVect )
%GET_PQ Summary of this function goes here
%   Detailed explanation goes here
    x=rVect(1); y=rVect(2); z=rVect(3);
    [rt,theta,phi]=ott13.xyz2rtp(x, y, z);
    
    nmax=obj.Nmax;
    R = ott13.z_rotation_matrix(theta, phi); %calculates an appropriate axis rotation off z.
    D = ott13.wigner_rotation_matrix(nmax,R);

    a=obj.coeff_a; b=obj.coeff_b;
    [A,B] = ott13.translate_z(nmax, rt);
    a2 = D'*(  A * D*a +  B * D*b ); % Wigner matricies here are hermitian. Therefore in MATLAB the D' operator is the inverse of D.
    b2 = D'*(  A * D*b +  B * D*a ); % In MATLAB operations on vectors are done first, therefore less calculation is done on the matricies.

    T=obj.Tmatrix;
    pq = T * [ a2; b2 ];
    p = pq(1:length(pq)/2);
    q = pq(length(pq)/2+1:end);
    
    obj.coeff_p=p;
    obj.coeff_q=q;

end


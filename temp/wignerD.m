function [D,Dnmax] = wignerD( nmax, R)
% wignerD.m
% Rotation matrix for rotation of spherical harmonics or T-matrices
%
% Usage:
% D = wignerD(nmax,R)
% [D,Dnmax] = wignerD(nmax,R)
% where
% R = cartesian coordinate rotation matrix. R is the Euler rotation
% R(alpha,beta,gamma) of axis, thus vector x'=xR (x is row vector).
% D = wigner D matrix
% Dnmax is the D_nmax, rotation matrix of n=nmax.
%
% D (and Dnmax) are sparse
%
% This method from Choi et al., J. Chem. Phys. 111: 8825-8831 (1999).
% Code adapted from ott by Nieminen.
%
% PACKAGE INFO

% Transform cartesian rotation matrix to spinor(?) rotation matrix
%
% Note that the order n = 1 scalar spherical harmonics are equal to
% orthogonal spinor vectors
% e+ = -exp(i*phi) sin(theta) / sqrt(2) = ( - x - iy )/sqrt(2)/r
% e- = exp(-i*phi) sin(theta) / sqrt(2) = ( x - iy )/sqrt(2)/r
% e0 = cos(theta) = z/r

% So, to transform cartesian coords to spinor coords,
% s = x C / r

C = [  1/sqrt(2) 0 -1/sqrt(2);
      -i/sqrt(2) 0 -i/sqrt(2);
       0         1  0 ];
invC = [ 1/sqrt(2) i/sqrt(2) 0;
         0         0         1;
        -1/sqrt(2) i/sqrt(2) 0 ];

% Since x' = x R, s' -> x' C = s invC R C -> s' = s (invC R C)
D = invC * R * C; 
%This is the normal D(l=1) for row vectors{-1,0,1}, can be verified by EQ(5.23) on P.109.
%Normal includes Mish, Choi and zeng.
% This is also the rotation sub-matrix for n = 1

%for (-1)^m omitted convention.
[X,Y]=meshgrid([-1,0,1]);
mt=(-1).^(Y-X);
D=mt.*D;

%iteration for D.
D1 = D.';% This transpose is just done for the reuse of the code below, and
%will transpose back at the end the function
DD = D1;

maxci = ott13.combined_index(nmax,nmax);
D = sparse(maxci,maxci);

D(1:3,1:3) = D1;

% Calculate for n = 2:nmax by recursion
for n = 2:nmax
    
    DDD = zeros(2*n+1);
    
    % Fill in whole block except for top and bottom row

    m0 = ones(2*n-1,1) * (-n:n);
    m1 = ((-n+1):(n-1)).' * ones(1,2*n+1);
    a = sqrt( (n+m0) .* (n-m0) ./ ( (n+m1) .* (n-m1) ) );
    b = sqrt( (n+m0) .* (n+m0-1) ./ ( 2*(n+m1) .* (n-m1) ) );
    
    DDD(2:end-1,2:end-1) = D1(2,2) * a(:,2:end-1) .* DD;
    DDD(2:end-1,3:end) = DDD(2:end-1,3:end) + D1(2,3) * b(:,3:end) .* DD;
    DDD(2:end-1,1:end-2) = DDD(2:end-1,1:end-2) + D1(2,1) * fliplr(b(:,3:end)) .* DD;
    
    % Top row
    
    m0 = (-n:n);
    c = sqrt( (n+m0).*(n-m0)/(n*(2*n-1)) );
    d = sqrt( (n+m0).*(n+m0-1)/(2*n*(2*n-1)) );
    
    DDD(1,2:end-1) = D1(1,2) * c(2:end-1) .* DD(1,:);
    DDD(1,3:end) = DDD(1,3:end) + D1(1,3) * d(3:end) .* DD(1,:);
    DDD(1,1:end-2) = DDD(1,1:end-2) + D1(1,1) * fliplr(d(3:end)) .* DD(1,:);
    
    % Bottom row
    
    DDD(end,2:end-1) = D1(3,2) * c(2:end-1) .* DD(end,:);
    DDD(end,3:end) = DDD(end,3:end) + D1(3,3) * d(3:end) .* DD(end,:);
    DDD(end,1:end-2) = DDD(end,1:end-2) + D1(3,1) * fliplr(d(3:end)) .* DD(end,:);

    % Dump into final matrix
    
    minci = ott13.combined_index(n,-n);
    maxci = ott13.combined_index(n,n);
    
    D(minci:maxci,minci:maxci) = DDD;
    DD = DDD;
    
end

D=D.';
Dnmax=DD.';
end

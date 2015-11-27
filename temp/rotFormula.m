clear;clc
n=1; m=1; Nmax=1;

kr0=1.0; theta0=pi/6; phi0=pi/4;
krP=1.0; thetaP=pi/6; phiP=0.0;

[M0, N0] = ott13.vswfcart(n,m,kr0,theta0,phi0,3);

[MP_1, NP_1] = ott13.vswfcart(n,-1,krP,thetaP,phiP,3);
[MP0, NP0] = ott13.vswfcart(n,0,krP,thetaP,phiP,3);
[MP1, NP1] = ott13.vswfcart(n,1,krP,thetaP,phiP,3);

R = ott13.z_rotation_matrix(0,pi/4);
D = ott13.wigner_rotation_matrix(Nmax,R);

D
disp([M0; MP_1,; MP1])

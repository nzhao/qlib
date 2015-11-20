%% test sphere harmoncial function
clc;
n=1;m=1;Nmax=1;
krL=0.5; thetaL=pi/3;phiL=pi/6;
krP=0.5; thetaP=0;phiP=0;
MP1 = spharm(n,m,thetaP,phiP)*(-1);MP1
R = ott13.z_rotation_matrix(pi/3,0);%R = rotation_matrix([0,1,0],pi/3); %The same as zeng, rotate sate.
D = ott13.wigner_rotation_matrix(Nmax,R);D=full(D);
D1=D'% This is the D of zeng, verified.
% add m'*alpha to get D2
alpha=phiL;
Dzeng=[D1(1,:)*exp(-1i*(-1)*alpha);D1(2,:)*exp(-1i*0*alpha);D1(3,:)*exp(-1i*1*alpha)];
D=full(Dzeng)
ML1 = spharm(n,1,thetaL,phiL)*(-1);
ML0 = spharm(n,0,thetaL,phiL);
ML_1 = spharm(n,-1,thetaL,phiL)*(-1)^(-1);
[ML_1;ML0;ML1]
% Mnew=D(1,1)*ML_1+D(1,2)*ML0+D(1,3)*ML1;[MP1;Mnew]
Mnew=D(1,3)*ML_1+D(2,3)*ML0+D(3,3)*ML1;[MP1;Mnew]

%% 
n=1;m=1;Nmax=1;
krL=0.5; thetaL=pi/3;phiL=pi/6;
krP=0.5; thetaP=0;phiP=0;
[MP1,NP1] = vswfcart(n,m,krP,thetaP,phiP);MP1=MP1*(-1)
R = ott13.z_rotation_matrix(pi/3,0);%R = rotation_matrix([0,1,0],pi/3); %The same as zeng, rotate sate.
D = ott13.wigner_rotation_matrix(Nmax,R);D=full(D);
D1=D'% This is the D of zeng
% add m'*alpha to get D2
alpha=phiL;
Dzeng=[D1(1,:)*exp(-1i*(-1)*alpha);D1(2,:)*exp(-1i*0*alpha);D1(3,:)*exp(-1i*1*alpha)];
D=full(Dzeng)
[ML1,NL1] = vswfcart(n,1,krL,thetaL,phiL);ML1=ML1*(-1);
[ML0,NL0] = vswfcart(n,0,krL,thetaL,phiL);
[ML_1,NL_1] = vswfcart(n,-1,krL,thetaL,phiL);ML_1=ML_1*(-1)^(-1);
[ML_1;ML0;ML1]
% Mnew=D(1,1)*ML_1+D(1,2)*ML0+D(1,3)*ML1;[MP1;Mnew]
Mnew=D(1,3)*ML_1+D(2,3)*ML0+D(3,3)*ML1;[MP1;Mnew]
[norm(Mnew),norm(MP1)]
R = ott13.z_rotation_matrix(thetaL,phiL);R=R';
Mnew=R*(Mnew.');Mnew=Mnew.';
[MP1;Mnew]

%% test the D
Nmax=1;
R = ott13.z_rotation_matrix(pi/3,0);%R = rotation_matrix([0,1,0],pi/3); %The same as zeng, rotate the sate.
D = ott13.wigner_rotation_matrix(Nmax,R);D=full(D)
[X,Y]=meshgrid([-1,0,1]);
mt=(-1).^(Y-X);
D1=D./mt% This is the D of zeng

R = ott13.z_rotation_matrix(-pi/3,0);
D = ott13.wigner_rotation_matrix(Nmax,R);D=full(D.')
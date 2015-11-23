%% test Ylm with the D from OTT:OK
clc;
n=1;m=1;Nmax=1;
krL=0.5; thetaL=pi/3;phiL=pi/6;
krP=0.5; thetaP=0;phiP=0;
R = ott13.z_rotation_matrix(thetaL,phiL);
D = ott13.wigner_rotation_matrix(Nmax,R);D=full(D.')% This is the Zeng's D, m={-1,0,1} order.
%test Ylm
MP1 = spharm(n,m,thetaP,phiP)*(-1);MP1;
ML1 = spharm(n,1,thetaL,phiL)*(-1);
ML0 = spharm(n,0,thetaL,phiL);
ML_1 = spharm(n,-1,thetaL,phiL)*(-1)^(-1);
[ML_1;ML0;ML1] %verified by mathecmatica
Mnew=D(1,1)*ML_1+D(2,1)*ML0+D(3,1)*ML1;[MP1;Mnew]
%test Eq(35) of P312 of zeng's book:OK.
EqL=D(:,2);
EqR=sqrt(4*pi/3)*[ML_1,ML0,ML1]';
[EqL';EqR']'
%test vector M
[MP1,NP1] = vswfcart(n,m,krP,thetaP,phiP);MP1=MP1*(-1);
[ML1,NL1] = vswfcart(n,1,krL,thetaL,phiL);ML1=ML1*(-1);
[ML0,NL0] = vswfcart(n,0,krL,thetaL,phiL);
[ML_1,NL_1] = vswfcart(n,-1,krL,thetaL,phiL);ML_1=ML_1*(-1)^(-1);
[ML_1;ML0;ML1];
Mnew=D(1,1)*ML_1+D(2,1)*ML0+D(3,1)*ML1;[MP1;Mnew];
R = ott13.z_rotation_matrix(thetaL,phiL);
Mnew=Mnew*R;
[MP1;Mnew]
%Ey has a -, why?

%% our own code
clc;
n=1;m=1;Nmax=1;
krL=0.5; thetaL=pi/3;phiL=pi/6;
krP=0.5; thetaP=0;phiP=0;
%these 2 lines get the d of zeng on P308, result verified by hand.
R = ott13.z_rotation_matrix(pi/3,0);%R = rotation_matrix([0,1,0],pi/3); %The same as zeng, rotate sate.
d = ott13.wigner_rotation_matrix(Nmax,R);d=full(d.');D1=d
alpha=phiL;% add m'*alpha to get D
Dzeng=[D1(1,:)*exp(-1i*(-1)*alpha);D1(2,:)*exp(-1i*0*alpha);D1(3,:)*exp(-1i*1*alpha)];
D=full(Dzeng)
%test sphere harmoncial function Ylm:OK
MP1 = spharm(n,m,thetaP,phiP)*(-1);
ML1 = spharm(n,1,thetaL,phiL)*(-1);
ML0 = spharm(n,0,thetaL,phiL);
ML_1 = spharm(n,-1,thetaL,phiL)*(-1)^(-1);
[ML_1;ML0;ML1];
Mnew=D(1,1)*ML_1+D(2,1)*ML0+D(3,1)*ML1;[MP1;Mnew]
%test Vector Mmn
[MP1,NP1] = vswfcart(n,m,krP,thetaP,phiP);MP1=MP1*(-1);
[ML1,NL1] = vswfcart(n,1,krL,thetaL,phiL);ML1=ML1*(-1);
[ML0,NL0] = vswfcart(n,0,krL,thetaL,phiL);
[ML_1,NL_1] = vswfcart(n,-1,krL,thetaL,phiL);ML_1=ML_1*(-1)^(-1);
[ML_1;ML0;ML1];
Mnew=D(1,1)*ML_1+D(2,1)*ML0+D(3,1)*ML1;[MP1;Mnew];
R = ott13.z_rotation_matrix(thetaL,phiL);
Mnew=Mnew*R;
[MP1;Mnew]
%Ey term has a -, why?

%% Now the field
[X,Y]=meshgrid([-1,0,1]);
mt=(-1).^(Y-X);
D1=D./mt


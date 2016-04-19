%Code01_07  %atomic properties
%Code09_04  %cycling transition matrices
%Code09_05  %compactification
%Code09_06  %compactification
%Code09_07  %left and right quantum numbers
%Code09_08  %optical pumping matrices
%Code09_09  %steady-state solution
%Code09_10  %plot distributions


Fp=diag(sqrt((1:2*fg).*(2*fg:-1:1)),1);
Fj(:,:,1)=(Fp+Fp')/2;
Fj(:,:,2)=(Fp-Fp')/(2*i);
Fj(:,:,3)=diag(fg:-1:-fg);
cff=[1;zeros(gg-1,1)];%ket vector |ff>
zz=cff*cff';%rho for spin pol along z
Rtheta=expm(-i*pi*Fj(:,:,2)/2);%90 degree rot. about y
xx=Rtheta*zz*Rtheta';%rho for spin pol. along x
nphi=50;%number of azimuthal sample points
phi=linspace(0,2*pi,nphi);
Wn=zeros(nphi,gg^2);
for k=1:nphi
    Rphi=expm(-i*phi(k)*Fj(:,:,3));
    nn=Rphi*xx*Rphi';%rho for spin parallel to n
    Wn(k,:)=(gg/4/pi)*nn(:)';%prob. to point along n
end
figure(2); clf; %momentum space
polar(phi,real(Wn*crhoin(:,ns+1))')
hold on;
polar(phi,real(Wn*crhoin(:,ns+1+round(ns/4)))','r')
polar(phi,real(Wn*crhoin(:,ns+1-round(ns/4)))','g')
figure(3);clf;%position space
rho0=sum(crhoin,2);%rho summed over all p
polar(phi,real(Wn*rho0)')
title('<n|\rho|n> for z = 0')
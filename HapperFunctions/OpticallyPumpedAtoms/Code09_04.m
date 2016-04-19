% Code01_07  %atomic properties
fg=input('ground-state spin, fg = '); fe=fg+1;
Mg=input('atomic mass in Daltons, Mg = '); Mg=Mg/NA;%to gram
lam=input('wavelength in nm, lam = '); lam=lam*1e-7;%to cm
rpg=input('pumping rate/recoil shift, Gpg/dwR= ');
xi=input('detuning in units of 1/te, xi = ');
eta=input('helicity, +/- 1; eta = ');
te=input('spontaneous lifetime in nsec, te = '); te=te*1e-9;%to s
ns=input('number of positive (or negative) momentum sidebands, ns = ');
gg=2*fg+1; ge=2*fe+1;%statistical weights
keg=2*pi/lam; weg=keg*c;%nominal spatial and temporal frequencies
D=sqrt(hbar*c^3*ge/(4*weg^3*te));%nominal electric dipole amplitude
dwR=hbar*keg^2/Mg;%recoil shift in rad/s
kap=dwR*te;%dimensionless recoil shift
Gpg=rpg*dwR;%mean pumping rate of ground-state atoms at rest
E0=-hbar*(xi+i/2)/te;%energy denom. for atoms at rest
Ek=sqrt(Gpg*gg*abs(E0)^2*te/(2*D^2));%electric field amplitude
ek=[1 1; i*eta -i*eta;0 0]/sqrt(1+eta^2);%polarization vectors
for k=fe:-1:-fe; %spherical components of dimensionless dipole op.
    for l=1:-1:-1
        for m=fg:-1:-fg
            if k+l==m
                Ds(fg-m+1,fe-k+1,2-l)=sqrt(3/gg)*cg(fe,k,1,l,fg,m);
            end
        end
    end
end
Dj(:,:,1)=(-Ds(:,:,1)+Ds(:,:,3))/sqrt(2);
Dj(:,:,2)=(-Ds(:,:,1)-Ds(:,:,3))/(i*sqrt(2));
Dj(:,:,3)=Ds(:,:,2); %Cartesian components
tV=zeros(ge,gg,2);%interaction; kr=1 or 2 for up or down
for kr=1:2
    for j=1:3%sum on Cartesian indices j
        tV(:,:,kr)=tV(:,:,kr)-D*Dj(:,:,j)'*Ek*ek(j,kr);
    end
end
Asge=zeros(gg*gg,ge*ge);%spontaneous emission
for j=1:3 %sum over three Cartesian axes
    Asge=Asge+(ge/3)*kron(conj(Dj(:,:,j)),Dj(:,:,j));
end
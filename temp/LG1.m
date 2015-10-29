clear; 
import model.phy.PhysicalObject.Lens
import model.phy.PhysicalObject.LaserBeam.ParaxialBeam.ParaxialLaguerreGaussianBeam

f=1.0;%focal distance in mm
NA=1.0; working_medium='vacuum';
lens=Lens(f, NA, working_medium);

power=1.0; 
wavelength=0.5; waist=1000.0; center=[0, 0, 0];  %in micron
px=1.0; py=0.0; p=0; l=1; 
incBeam1=ParaxialLaguerreGaussianBeam(wavelength, power, waist, center, p, l, px, py, 'vacuum');

lg1=model.phy.PhysicalObject.LaserBeam.AplanaticBeam.LinearCircularPol(lens, incBeam1);

Nmax=40;
lg1.getVSWFcoeff(Nmax);

% x=1.0; y=0.1; z=0.1;
% [e1plus, h1plus]=lg1.wavefunction(x, y, z);
% [e2plus, h2plus]=lg1.focBeam.wavefunction(x, y, z);
% [e1plus;e2plus]
% [h1plus;h2plus]

a0=lg1.focBeam.aNNZ(:,3);
b0=lg1.focBeam.bNNZ(:,3);
n=lg1.focBeam.aNNZ(:,1);
m=lg1.focBeam.aNNZ(:,2);
[a,b,n,m] = ott13.make_beam_vector(a0,b0,n,m);


k=lg1.focBeam.k; n_relative=1.5; radius =0.1;
T = ott13.tmatrix_mie(Nmax,k,k*n_relative,radius);
%%

z = linspace(-8,8,200);
r = linspace(-4,4,200);

fz = zeros(size(z));
fr = zeros(size(r));

%root power for nomalization to a and b individually.
pwr = sqrt(sum( abs(a).^2 + abs(b).^2 ));

%normalize total momentum of wave sum to 1. Not good for SI EM field.
a=a/pwr;
b=b/pwr;

%calculate the force along z
for nz = 1:length(z)
    
    [A,B] = ott13.translate_z(Nmax,z(nz));
    a2 = ( A*a + B*b );
    b2 = ( A*b + B*a );
    
    pq = T * [ a2; b2 ];
    p = pq(1:length(pq)/2);
    q = pq(length(pq)/2+1:end);
    
    fz(nz) = ott13.force_z(n,m,a2,b2,p,q);
    
end

zeroindex=find(fz<0,1);

if length(zeroindex)~=0
    %fit to third order polynomial the local points. (only works when dz
    %sufficiently small)
    pz=polyfit(z(max([zeroindex-2,1]):min([zeroindex+2,length(z)])),fz(max([zeroindex-2,1]):min([zeroindex+2,length(z)])),2);
    root_z=roots(pz); %find roots of 3rd order poly.
    dpz=[3*pz(1),2*pz(2),1*pz(3)]; %derivative of 3rd order poly.
    
    real_z=root_z(imag(root_z)==0); % finds real roots only.
    
    rootsofsign=polyval(dpz,real_z); %roots that are stable
    zeq=real_z(rootsofsign<0); %there is at most 1 stable root. critical roots give error.
    try
        zeq=zeq(abs(zeq-z(zeroindex))==min(abs(zeq-z(zeroindex))));
    end
else
    zeq=[];
end

if length(zeq)==0
    warning('No axial equilibrium in range!')
    zeq=0;
end

% equilibrium probably only correct to 1 part in 1000.
%now work out spherical coordinates along that axis:
[rt,theta,phi]=ott13.xyz2rtp(r,0,zeq);

%calculate the x-axis coefficients for force calculation.
Rx = ott13.z_rotation_matrix(pi/2,0);
Dx = ott13.wigner_rotation_matrix(Nmax,Rx);

for nr = 1:length(r)
    
    R = ott13.z_rotation_matrix(theta(nr),phi(nr)); %calculates an appropriate axis rotation off z.
    D = ott13.wigner_rotation_matrix(Nmax,R);
    
    [A,B] = ott13.translate_z(Nmax,rt(nr));
    a2 = D'*(  A * D*a +  B * D*b ); % Wigner matricies here are hermitian. Therefore in MATLAB the D' operator is the inverse of D.
    b2 = D'*(  A * D*b +  B * D*a ); % In MATLAB operations on vectors are done first, therefore less calculation is done on the matricies.
    
    pq = T * [ a2; b2 ];
    p = pq(1:length(pq)/2);
    q = pq(length(pq)/2+1:end);
    
    fr(nr) = ott13.force_z(n,m,Dx*a2,Dx*b2,Dx*p,Dx*q); %Dx makes the z-force calculation the x-force calculation.
    
end
%     timetakes(ii)=toc;
% end
%
% plot(log([4:length(timetakes)])/log(10),log(timetakes(4:end)-timetakes(3:end-1))/log(10))
% plot([1:length(timetakes)-1],timetakes(2:end)-timetakes(1:end-1))

toc
figure; plot(z,fz);
xlabel('{\it z} (x\lambda)');
ylabel('{\it Q_z}');
aa = axis;
hold on
line(aa(1:2),[ 0 0 ],'linestyle',':');
line([0 0],aa(3:4),'linestyle',':');

figure; plot(r,fr);
xlabel('{\it r} (x\lambda)');
ylabel('{\it Q_r}');
aa = axis;
hold on
line(aa(1:2),[ 0 0 ],'linestyle',':');
line([0 0],aa(3:4),'linestyle',':');

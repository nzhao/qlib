function Dj=happerMatrixCoupled(obj,J,magB, projection)

if nargin<4
    projection='cartesian';
end
if J==1.5
    ge=obj.dimE2;
    ele=obj.e2Spin;
elseif J==0.5
    ge=obj.dimE1;
    ele=obj.e1Spin;
else 
    disp('Error J')
end
S=obj.parameters.spin_S;
gg=obj.dimG;
gS=obj.gSpin.dim;
gJ=ele.dim;
gI=obj.nSpin.dim;
[~,Ug,~,Ue]=obj.eigenValueVector(J,magB);
sDs=zeros(gS,gJ,3); %spherical projections in electronic space
for k=J:-1:-J
    for l=1:-1:-1
        for m=S:-1:-S
            if k+l==m
                sDs(S-m+1,J-k+1,2-l)=sqrt(3/gS)*cg(J,k,1,l,S,m);
            end
        end
    end
end

if strcmp(projection, 'cartesian')
        sD(:,:,1)=(-sDs(:,:,1)+sDs(:,:,3))/sqrt(2);
        sD(:,:,2)=(-sDs(:,:,1)-sDs(:,:,3))/(1j*sqrt(2));
        sD(:,:,3)=sDs(:,:,2); %Cartesian projections in electronic space
else %'spherical'
        sD=sDs;
end

gDj=zeros(gg,ge);
Dj=zeros(gg,ge);
for k=1:3
    gDj(:,:,k)=kron(eye(gI),sD(:,:,k));% grave matrix;
end

for j=1:3;
    Dj(:,:,j)=Ug'*gDj(:,:,j)*Ue;
end


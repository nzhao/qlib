%Code02_01 %constants, atomic properties
%Code03_01 %uncoupled spin matrices
%Code03_02 %energy basis states, unitary matrices
%Code03_06 %zero-field energies
%Code04_01 %projection operators
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
sDj(:,:,1)=(-sDs(:,:,1)+sDs(:,:,3))/sqrt(2);
sDj(:,:,2)=(-sDs(:,:,1)-sDs(:,:,3))/(i*sqrt(2));
sDj(:,:,3)=sDs(:,:,2); %Cartesian projections in electronic space
for k=1:3
    gDj(:,:,k)=kron(eye(gI),sDj(:,:,k));% grave matrix;
end

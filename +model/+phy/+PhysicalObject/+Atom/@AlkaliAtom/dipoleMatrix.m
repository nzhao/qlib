function Djss = dipoleMatrix( obj, J, magB )
%DIPOLEMATRIX Summary of this function goes here
%   Detailed explanation goes here
    [~,Ug,~,Ue]=obj.eigenValueVector(J,magB);
    sDs=zeros(gJ,gS,3); %spherical projections in electronic space
    for k=J:-1:-J
        for l=1:-1:-1
            for m=S:-1:-S
                if m+l==k
                    sDs(J-k+1,S-m+1,2-l)=(-1)^(J-S)*sqrt(3/gJ)*cg(S,m,1,l,J,k);
                end
            end
        end
    end
    for k=1:3
        gDs(:,:,k)=kron(eye(gI),sDs(:,:,k));
    end

    for j=1:3;
        Djs(:,:,j)=Ue'*gDs(:,:,j)*Ug;
    end

    for j=1:3;
        x=max(max(abs(Djs(:,:,j))));
        Djss(:,:,j)=Djs(:,:,j)/x;
    end
end


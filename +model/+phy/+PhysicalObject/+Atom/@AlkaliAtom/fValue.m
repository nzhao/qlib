function f=fValue(obj,J,magB)
if J==1.5
    gJ=obj.e2Spin.dim;
    ge=obj.dimE2;
     elseif J==0.5
         gJ=obj.e1Spin.dim;
         ge=obj.dimE1;
         else
        disp('Error J');
end
   gI=obj.nSpin.dim;   
    sIj(:,:,1)=nuc.sx;
    sIj(:,:,2)=nuc.sy;
    sIj(:,:,3)=nuc.sz;

    sJj(:,:,1)=ele.sx;
    sJj(:,:,2)=ele.sy;
    sJj(:,:,3)=ele.sz; 
    
    aIje=zeros(ge,ge);
    gJj=zeros(ge,ge);
    
for k=1:3
        aIje(:,:,k)=kron(sIj(:,:,k),eye(gJ));
        gJj(:,:,k)=kron(eye(gI),sJj(:,:,k));
end
uIJ=matdot(aIje,gJj);%uncoupled I.J
fSquare=I*(I+1)+J*(J+1)+uIJ;
gsHami=rb.gsHamiltonian(magB);
[gsV, ~]=eig(gsHami);
f=gsV'*fSquare*gsV; 
end
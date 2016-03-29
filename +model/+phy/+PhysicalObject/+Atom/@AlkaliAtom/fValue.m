function f=fValue(obj,J,magB)
nuc=obj.nSpin;  ele=obj.gSpin;
if J==1.5
    gJ=obj.e2Spin.dim;
    ge=obj.dimE2;
     elseif J==0.5
         gJ=obj.e1Spin.dim;
         ge=obj.dimE1;
         else
        disp('Error J');
end
I=obj.parameters.spin_I;
    
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
fSquare=I*(I+1)*eye(ge)+J*(J+1)*eye(ge)+2*uIJ;
gsHami=obj.gsHamiltonian(magB);
[gsV, ~]=eig(gsHami);
f=zeros(1,8);
f2=zeros(1,8);
for i=1:8
    f2(i)=gsV(:,i)'*fSquare*gsV(:,i);
   f(i)=0.5*(sqrt(4*f2(i)+1)-1);
end
end
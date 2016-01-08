<<<<<<< HEAD
function G1 = pumpingMatrix(obj,J,magB)
    gg=obj.dimG;
    if J==0.5
        ge=obj.dimE1;
    elseif J==1.5
        ge=obj.dimE2;
    else
        disp('error')
    end
    gt=(ge+gg)^2;
    
    Pg=eye(gg);Pe=eye(ge);
    n1=1:ge^2; n2=ge^2+1:ge^2+ge*gg; n3=ge^2+ge*gg+1:ge^2+2*ge*gg;
    n4=ge^2+2*ge*gg+1:(ge+gg)^2; 
    tV=obj.electricDipoleInteraction(J,magB);
    G1=zeros(gt,gt);
    G1(n1,n2)=kron(Pe,tV)*1j/hbar;%upper off diagonal elements 
    G1(n1,n3)=-kron(conj(tV),Pe)*1j/hbar; 
    G1(n2,n4)=-kron(conj(tV),Pg)*1j/hbar; 
    G1(n3,n4)=kron(Pg,tV)*1j/hbar; 
    G1=G1-G1';%add antihermitian conjugate 
end

=======
function G1 = pumpingMatrix(obj,J,magB)
gg=obj.dimG;
if J==0.5
    ge=obj.dimE1;
elseif J==1.5
    ge=obj.dimE2;
else disp('error')
end
Pg=eye(gg);Pe=eye(ge);
n1=1:ge^2; n2=ge^2+1:ge^2+ge*gg; n3=ge^2+ge*gg+1:ge^2+2*ge*gg; ... 
n4=ge^2+2*ge*gg+1:(ge+gg)^2; 
tV=obj.electricDipoleInteraction(J,magB);
G1=zeros(gt,gt);
G1(n1,n2)=kron(Pe,tV)*1j/hbar;%upper off diagonal elements 
G1(n1,n3)=-kron(conj(tV),Pe)*1j/hbar; 
G1(n2,n4)=-kron(conj(tV),Pg)*1j/hbar; 
G1(n3,n4)=kron(Pg,tV)*1j/hbar; 
G1=G1-G1';%add antihermitian conjugate 
end

>>>>>>> master

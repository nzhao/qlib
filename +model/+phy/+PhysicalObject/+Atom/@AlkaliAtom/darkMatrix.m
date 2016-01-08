<<<<<<< HEAD
function G0=darkMatrix(obj,J,magB)
    if J==1.5
        te=obj.parameters.te1;%spontaneous P1/2 lifetime in s
        ge=obj.dimE2;
    elseif J==0.5
        te=obj.parameters.te2;%spontaneous P1/2 lifetime in s
        ge=obj.dimE1;
    end
    gg=obj.dimG;
    gt=(gg+ge)^2;
    [Eg,~,Ee,~]=obj.eigenValueVector(J,magB);
    Hee=Ee*ones(1,ge)-ones(ge,1)*Ee';
    Hge=Eg*ones(1,ge)-ones(gg,1)*Ee';
    Heg=Ee*ones(1,gg)-ones(ge,1)*Eg';
    Hgg=Eg*ones(1,gg)-ones(gg,1)*Eg';
    n1=1:ge^2; n2=ge^2+1:ge^2+ge*gg; n3=ge^2+ge*gg+1:ge^2+2*ge*gg; ... 
    n4=ge^2+2*ge*gg+1:(ge+gg)^2; 
    G0=zeros(gt,gt);
    G0(n1,n1)=diag(Hee(:)*1j/hbar+1/te);%diagonal elements 
    G0(n2,n2)=diag(Hge(:)*1j/hbar+1/(2*te)); 
    G0(n3,n3)=diag(Heg(:)*1j/hbar+1/(2*te)); 
    G0(n4,n4)=diag(Hgg(:)*1j/hbar); 
    Asge=obj.coupledSpontaneousMatrix(J,magB);
    G0(n4,n1)=-Asge/te;%repopulation by stimulated emission 
end

=======
function G0=darkMatrix(obj,J,magB)
if J==1.5
    te=obj.parameters.te1;%spontaneous P1/2 lifetime in s
    ge=obj.dimE2;
elseif J==0.5
    te=obj.parameters.te2;%spontaneous P1/2 lifetime in s
    ge=obj.dimE1;
end
gg=obj.dimG;
gt=(gg+ge)^2;
[Eg,~,Ee,~]=obj.eigenValueVector(J,magB);
Hee=Ee*ones(1,ge)-ones(ge,1)*Ee';
Hge=Eg*ones(1,ge)-ones(gg,1)*Ee';
Heg=Ee*ones(1,gg)-ones(ge,1)*Eg';
Hgg=Eg*ones(1,gg)-ones(gg,1)*Eg';
n1=1:ge^2; n2=ge^2+1:ge^2+ge*gg; n3=ge^2+ge*gg+1:ge^2+2*ge*gg; ... 
n4=ge^2+2*ge*gg+1:(ge+gg)^2; 
G0=zeros(gt,gt);
G0(n1,n1)=diag(Hee(:)*1j/hbar+1/te);%diagonal elements 
G0(n2,n2)=diag(Hge(:)*1j/hbar+1/(2*te)); 
G0(n3,n3)=diag(Heg(:)*1j/hbar+1/(2*te)); 
G0(n4,n4)=diag(Hgg(:)*1j/hbar); 
Asge=obj.coupledSpontaneousMatrix(J,magB);
G0(n4,n1)=-Asge/te;%repopulation by stimulated emission 
end

>>>>>>> master

<<<<<<< HEAD
function G2= collisionsMatrix(obj,J)
    if J==1.5
        ge=obj.dimE2;
        te=obj.parameters.te1;
    elseif J==0.5
        ge=obj.dimE1;
        te=obj.parameters.te2;
    end
    gg=obj.dimG;
    Gmc=1/te;
    n4=ge^2+2*ge*gg+1:(ge+gg)^2; 
    Pg=eye(gg);cPg=Pg(:);rPg=cPg(:)';
    Acgg=eye(gg*gg)-cPg*rPg/gg;%uniform-relaxation matrix 
    G2=0;
    G2(n4,n4)=Gmc*Acgg; 
end

=======
function G2= collisionsMatrix(obj,J)
if J==1.5
    ge=obj.dimE2;
    te=obj.parameters.te1;
elseif J==0.5
    ge=obj.dimE1;
    te=obj.parameters.te2;
end
gg=obj.dimG;
Gmc=1/te;
n4=ge^2+2*ge*gg+1:(ge+gg)^2; 
Pg=eye(gg);cPg=Pg(:);rPg=cPg(:)';
Acgg=eye(gg*gg)-cPg*rPg/gg;%uniform-relaxation matrix 
G2=0;
G2(n4,n4)=Gmc*Acgg; 
end

>>>>>>> master

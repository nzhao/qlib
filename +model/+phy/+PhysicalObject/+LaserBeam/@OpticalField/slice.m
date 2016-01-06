function [data, fig,data3] = slice( obj, r0, r1, r2, n1, n2)
%SLICE Summary of this function goes here
%   Detailed explanation goes here
% This is a vector field with [E,H] computed simutaneously and plot E
%with abs(E).
%and store [r,E] in data.
%
%This function will be more powerful to add 'component' as linecut.

data=zeros( (n1+1)*(n2+1), 6);
data3=zeros( (n1+1)*(n2+1), 3);
x=zeros( 1, (n1+1)*(n2+1));
y=zeros( 1, (n1+1)*(n2+1));
z=zeros( 1, (n1+1)*(n2+1));

dr1= (r1-r0)/n1;
dr2= (r2-r0)/n2;
dr1Norm=norm(dr1);indx1=find(dr1Norm);indx1=indx1(1);x0tmp=r0(indx1);
dr2Norm=norm(dr2);indx2=find(dr2Norm);indx2=indx2(1);y0tmp=r0(indx2);

qq=0;
for jj=0:n1
    disp(jj);
    for kk=0:n2
        qq=qq+1;
        r=r0+jj*dr1+kk*dr2;
        x(qq)=x0tmp+jj*dr1Norm;
        y(qq)=y0tmp+kk*dr2Norm;
        Field=obj.wavefunction(r(1), r(2), r(3));
        z(qq)=norm(Field);
        data(qq, :)=[r, Field];
        data3(qq, :)=[x(qq),y(qq),z(qq)];
    end
end

X=reshape(x, [n2+1, n1+1]);
Y=reshape(y, [n2+1, n1+1]);
Z=reshape(z, [n2+1, n1+1]);
fig=surf(X, Y, Z);

end


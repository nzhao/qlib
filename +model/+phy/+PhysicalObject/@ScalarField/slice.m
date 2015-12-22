function [data, fig] = slice( obj, r0, r1, r2, n1, n2,component)
%SLICE function will give out the field distribution of a SCALAR field
%   in rectangle [r0,r1]*[r0,r2] with (n1+1)*(n2+1) grid points.
%
% Field form: complex field Field(x,y,z).

error('slice for scalar field is being added!');
data=zeros( (n1+1)*(n2+1), 4);
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
        z(qq)=obj.wavefunction(r(1), r(2), r(3));
        %         data(qq, :)=[r, z(qq)];
        data(qq, :)=[0,x,y, z(qq)];
    end
end

if nargin>6
    X=reshape(x, [n1+1, n2+1]);
    Y=reshape(y, [n1+1, n2+1]);
    Field=reshape(z, [n1+1, n2+1]);
    switch char(component)
        case 'real'
            fig=surf(X,Y,real(Field));
        case 'imag'
            fig=surf(X,Y,imag(Field));
        case 'abs'
            fig=surf(X,Y,abs(Field));
        case 'angle'
            fig=surf(X,Y,angle(Field));
    end
end

end


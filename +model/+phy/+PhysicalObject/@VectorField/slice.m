function [data, fig] = slice( obj, r0, r1, r2, n1, n2)
%SLICE Summary of this function goes here
%   Detailed explanation goes here
%
%now slice is only for Scalarfield
    data=zeros( (2*n1+1)*(2*n2+1), 4);
    x=zeros( 1, (2*n1+1)*(2*n2+1));
    y=zeros( 1, (2*n1+1)*(2*n2+1));
    z=zeros( 1, (2*n1+1)*(2*n2+1));

    dr1= (r1-r0)/n1;
    dr2= (r2-r0)/n2;
    dr1Norm=norm(dr1);
    dr2Norm=norm(dr2);

    qq=0;
    for jj=-n1:n1
        disp(jj);
        for kk=-n2:n2
            qq=qq+1;
            r=r0+jj*dr1+kk*dr2;
            x(qq)=jj*dr1Norm;
            y(qq)=kk*dr2Norm;
            z(qq)=obj.wavefunction(r(1), r(2), r(3));
            data(qq, :)=[r, z(qq)];
        end
    end

    X=reshape(x, [2*n1+1, 2*n2+1]);
    Y=reshape(y, [2*n1+1, 2*n2+1]);
    Z=reshape(abs(z), [2*n1+1, 2*n2+1]);
    fig=surf(X, Y, Z);

end


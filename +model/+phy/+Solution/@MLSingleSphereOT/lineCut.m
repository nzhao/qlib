function [data, fig]= lineCut(obj, r0, r1, n, component)
%LINECUT Summary of this function goes here
%   Detailed explanation goes here

    x=zeros(n+1, 1);
    data=zeros(n+1,6);
    dr=(r1-r0)/n;
    drNorm=norm(dr);
    
    indx=find(dr);
    xtmp=(dr(1)==0)+(dr(2)==0)+(dr(3)==0);
    if xtmp==3
        print('Input is a single point!');
    elseif xtmp==2 %along an axis
        for kk=1:n+1
            r=r0+(kk-1)*dr;
            x(kk)=r0(indx)+(kk-1)*drNorm;% for index axis only
            Field=obj.wavefunction(r(1), r(2), r(3));
            data(kk,:)=[r, Field];
        end
    else
        for kk=1:n+1
            r=r0+(kk-1)*dr;
            x(kk)=(kk-1)*drNorm;
            Field=obj.wavefunction(r(1), r(2), r(3));
            data(kk,:)=[r, Field];
        end
    end
    
    if nargin>4
    Ex=data(:, 4); Ey=data(:, 5); Ez=data(:, 6); Ea=conj(Ex).*Ex+conj(Ey).*Ey+conj(Ez).*Ez;
    switch char(component)
        case 'ExR'
            fig=plot(x, real(Ex), 'r-');
        case 'ExI'
            fig=plot(x, imag(Ex), 'r-');
        case 'EyR'
            fig=plot(x, real(Ey), 'r-');
        case 'EyI'
            fig=plot(x, imag(Ey), 'r-');
        case 'EzR'
            fig=plot(x, real(Ez), 'r-');
        case 'EzI'
            fig=plot(x, imag(Ez), 'r-');
        case 'Ea'
            fig=plot(x, Ea, 'r-');
    end
    end

end


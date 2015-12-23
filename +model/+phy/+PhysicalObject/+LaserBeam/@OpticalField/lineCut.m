function [data, fig]= lineCut(obj, r0, r1, n, component)
%LINECUT Summary of this function goes here
%   Detailed explanation goes here
% This is a vector field with [E,H] computed simutaneously and plot E
% with seven possible options {ExR,ExI,EyR,EyI,EzR,EzI,Ea}.
%and store [r,E,H] in data.

    x=zeros(n+1, 1);
    data=zeros(n+1,9);
    dr=(r1-r0)/n;
    drNorm=norm(dr);
    
    indx=find(dr);indx=indx(1);
    xtmp=(dr(1)==0)+(dr(2)==0)+(dr(3)==0);
    if xtmp==3
        print('Input is a single point!');
    elseif xtmp==2 %along an axis
        r0tmp=r0(indx);
        for kk=1:n+1
            r=r0+(kk-1)*dr;
            x(kk)=r0tmp+(kk-1)*drNorm;% for index axis only
            [eField, hField]=obj.wavefunction(r(1), r(2), r(3));
            data(kk,:)=[r, eField, hField];
        end
    else
        for kk=1:n+1
            r=r0+(kk-1)*dr;
            x(kk)=(kk-1)*drNorm;
            [eField, hField]=obj.wavefunction(r(1), r(2), r(3));
            data(kk,:)=[r, eField, hField];
        end
    end
    
    if nargin>4
    Ex=data(:, 4); Ey=data(:, 5); Ez=data(:, 6); Ea=conj(Ex).*Ex+conj(Ey).*Ey+conj(Ez).*Ez;
    Hx=data(:, 7); Hy=data(:, 8); Hz=data(:, 9); Ha=conj(Hx).*Hx+conj(Hy).*Hy+conj(Hz).*Hz; 
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


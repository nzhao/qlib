function [data, fig]= lineCut(obj, r0, r1, n, component)
%LINECUT Summary of this function goes here
%   Detailed explanation goes here

    x=zeros(n+1, 1);
    data=zeros(n+1, 9);
    dr=(r1-r0)/n;
    drNorm=norm(dr);

    for kk=1:n+1
        r=r0+(kk-1)*dr;
        x(kk)=(kk-1)*drNorm;
        [eField, hField]=obj.wavefunction(r(1), r(2), r(3));
        data(kk,:)=[r, eField, hField];
    end
    
    Ex=data(:, 4); Ey=data(:, 5); Ez=data(:, 6); Ea=conj(Ex).*Ex+conj(Ey).*Ey+conj(Ez).*Ez;
    Hx=data(:, 7); Hy=data(:, 8); Hz=data(:, 9); Ha=conj(Hx).*Hx+conj(Hy).*Hy+conj(Hz).*Hz;
    switch char(component)
        case 'ExR'
            fig=plot(x, real(Ex), 'ro-');
        case 'ExI'
            fig=plot(x, imag(Ex), 'ro-');
        case 'EyR'
            fig=plot(x, real(Ey), 'ro-');
        case 'EyI'
            fig=plot(x, imag(Ey), 'ro-');
        case 'EzR'
            fig=plot(x, real(Ez), 'ro-');
        case 'EzI'
            fig=plot(x, imag(Ez), 'ro-');
        case 'Ea'
            fig=plot(x, Ea, 'ro-');
    end

end


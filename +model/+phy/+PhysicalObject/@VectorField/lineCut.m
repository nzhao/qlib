function [data, fig]= lineCut(obj, r0, r1, n, component)
%LINECUT function will give out the field distribution of a Vector field
%   along r0->r1 with n steps (i.e, n+1 points).
%
% Field form: complex 3D field Field(x,y,z) with output data=[r,Field].
%fig plot with component options {ExR,ExI,EyR,EyI,EzR,EzI,Ea}.

x=zeros(n+1, 1);
data=zeros(n+1,6);
dr=(r1-r0)/n;
drNorm=norm(dr);

indx=find(dr);indx=indx(1);
%xtmp=(dr(1)==0)+(dr(2)==0)+(dr(3)==0);
xtmp=sum(~logical(dr));
if xtmp==3
    print('Input is a single point!');
elseif xtmp==2 %If along an axis, show the figure x axis labeled with axis value
    r0tmp=r0(indx);
    for kk=1:n+1
        r=r0+(kk-1)*dr;
        x(kk)=r0tmp+(kk-1)*drNorm;% for index axis only
        Field=obj.wavefunction(r(1), r(2), r(3));
        data(kk,:)=[r, Field];
    end
else           %not along an axis, show the figure x axis label with step number.
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


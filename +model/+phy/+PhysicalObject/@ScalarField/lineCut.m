function [data, fig]= lineCut(obj, r0, r1, n,component)
%LINECUT function will give out the field distribution of a SCALAR field
%   along r0->r1 with n steps (i.e, n+1 points).
%
% Field form: complex field Field(x,y,z).

x=zeros(n+1, 1);
data=zeros(n+1,4);
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
    Field=data(:, 4);
    switch char(component)
        case 'real'
            fig=plot(x, real(Field), 'r-');
        case 'imag'
            fig=plot(x, imag(Field), 'r-');
        case 'abs'
            fig=plot(x, abs(Field), 'r-');
        case 'angle'
            fig=plot(x, angle(Field), 'r-');
    end
end

end


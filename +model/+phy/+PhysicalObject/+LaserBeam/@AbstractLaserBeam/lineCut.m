function [data, fig]= lineCut(obj, r0, r1, n, funcString)
%LINECUT Summary of this function goes here
%   Detailed explanation goes here
    if nargin==4
        funcString='wavefunction';
    end

    data=zeros(n+1, 4);
    x=zeros(1, n+1);
    y=zeros(1, n+1);
    dr=(r1-r0)/n;
    drNorm=norm(dr);

    for kk=1:n+1
        r=r0+(kk-1)*dr;
        x(kk)=(kk-1)*drNorm;
        
        if strcmp(funcString,'wavefunction')
            y(kk)=obj.wavefunction(r(1), r(2), r(3));
        elseif strcmp(funcString, 'field')
            [ef, ~]=obj.field(r(1), r(2), r(3));
            y(kk)=ef*ef';
        else
            disp('error');
        end

        data(kk,:)=[r, y(kk)];
    end
    fig=plot(x, abs(y));

end


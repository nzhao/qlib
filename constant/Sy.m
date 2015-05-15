function mat = Sy( dim )
%SY Summary of this function goes here
%   Detailed explanation goes here
% if dim==2
%     mat=0.5*[0 -1j; 1j 0];
% else
%     mat=0;
% end

 spinqc=0.5*(dim-1);
    halfmat=zeros(dim,dim);
    for m=1:dim
        for n=1:dim
            if m==n+1
                  halfmat(m,n)=0.5*1i*sqrt(spinqc*(spinqc+1)-(m-1-spinqc)*(n-1-spinqc));
            end
        end
    end
    mat=halfmat+halfmat';
end


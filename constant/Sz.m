function mat = Sz( dim )
%SZ Summary of this function goes here
%   Detailed explanation goes here
% if dim==2
%     mat=0.5*[1 0; 0 -1];
% else
%     mat=0;
% end
    spinqc=0.5*(dim-1);
    diavec=-spinqc:spinqc;
    mat=-diag(diavec);
    
end


function [NV invM]= nullfast(M) 
K=max(max(abs(M)))*1e-15; warning off;%search the largest matrix element 
invM=K*inv(M+K*eye(length(M))); 
[i j]=max(sum(invM));%find the dominant matrix column 
NV=invM(:,j);%pick up the matrix column as the null vector 
NV=NV/sqrt((NV'*NV));%normalize the null vector 

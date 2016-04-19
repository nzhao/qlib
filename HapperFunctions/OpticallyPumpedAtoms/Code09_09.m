% Code01_07  %atomic properties
% Code09_04  %cycling transition matrices
% Code09_05  %compactification
% Code09_06  %compactification
% Code09_07  %left and right quantum numbers
% Code09_08  %optical pumping matrices

G=Aop+i*diag((pp.^2-qq.^2)/(2*rpg));%evolution operator
rhoin=nullfast(G);%find steady state
rhoin=rhoin/(lp'*rhoin);%normalize
crhoin=zeros(gg^2,2*ns+1);%initialize rho versus momentum
for k=1:maxpmq+1
    x=rhoin(pp-qq==maxpmq+2-2*k);
    nx=length(x)/(2*ns+1);
    y=reshape(x,nx,2*ns+1);
    l=logical(lpmq(:,k)*ones(1,2*ns+1));
    crhoin(l)=y;
end
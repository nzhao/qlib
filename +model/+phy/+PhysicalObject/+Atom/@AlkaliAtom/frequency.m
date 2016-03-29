
blist=0:0.0010:1.0000;
f=zeros(length(blist),1);
for i=1:length(blist)
gsHami=rb.gsHamiltonian(blist(i));
[~, gsD]=eig(gsHami);
gsValue=diag(gsD);
wp=gsValue(8)-gsValue(1);
wp1=gsValue(4)-gsValue(3);
f(i)=(wp-wp1)/2/pi;
end
plot(blist,f);

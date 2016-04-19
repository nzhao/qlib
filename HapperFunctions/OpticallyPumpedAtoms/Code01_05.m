%Code01_03 %input Code 1.3
rhoin = null(G); rhoin = rhoin/(rPS*rhoin); 
plot(t,real(rSz*rhoin)*ones(1,nt),'b-'); 
plot(t,real(rSx*rhoin)*ones(1,nt),'r-.'); 
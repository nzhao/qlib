% Code01_07  %atomic properties
% Code09_04  %cycling transition matrices
% Code09_05  %compactification
% Code09_06  %compactification
% Code09_07  %left and right quantum numbers
% Code09_08  %optical pumping matrices
% Code09_09  %steady-state solution

m=ns:-1:-ns;%listmomentum samples 
Nin=(real(lpg'*crhoin))';%totalpopulation permomentum state 
figure(1);clf 
subplot(2,1,1) 
plot(m,Nin,'r-'); 
grid on ;hold on; ylabel('Tr[\rho^{(p)}]') 
rhomu=real(crhoin(lpg,:));%sublevelpopulations versusp 
subplot(2,1,2);plot(m,rhomu); grid on 
xlabel('Momentum, p,in units of h/\lambda') 
legend('Populations of sublevels \langle \mu|\rho^{(p)}|\mu\rangle') 

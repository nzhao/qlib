%Code02_01 %constants, atomic properties
%Code03_01 %uncoupled spin matrices
%Code03_02 %energy basis states, unitary matrices
%Code03_06 %zero-field energies
%Code04_01 %projection operators
%Code05_02 %spherical projections in electronic space
%Code05_03 %matrices in energy basis, low field labels
%Code05_04 %spontaneous emission matrices
%Code05_05 %light characteristics, interaction matrix
%Code05_06 %energy difference matrices
%Code05_07 %Optical Bloch Equations with uniform damping
nw=21;dw=linspace(Dw-3/te,Dw+3/te,nw); rhow= zeros(gt,nw);
for k=1:nw
    G=G0+G1+G2+dw(k)*dGdw;
    rhow(:,k)=null(G);rhow(:,k)=rhow(:,k)/(rP*rhow(:,k));
end
figure(2); clf;
subplot(2,1,1)
plot(dw/(2*pi*1e6),real(rNg*rhow),'b-');hold on;%statepopulations
plot(dw/(2*pi*1e6),real(rNe*rhow),'r-.');grid on;
ylabel('StatePopulations');
legend('Ng','Ne')
subplot(2,1,2);%sublevel populations
plot(dw/(2*pi*1e6),real(real(rhow(LrNg,:))),'b-');hold on;
plot(dw/(2*pi*1e6),real(real(rhow(LrNe,:))),'r-.');grid on;
xlabel('Detuning,\Delta\nu inMHz');
ylabel('SublevelPopulations');

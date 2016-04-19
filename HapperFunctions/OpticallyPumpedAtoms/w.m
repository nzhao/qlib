function f=w(z); 
%Computes the function w(z)=exp(-z^2)erfc(-iz) using a rational 
%series with N terms. It is assumed that Im(z)>0 or Im(z)=0. 
%we use N=10, but higher accuracy can be obtained with larger N. 
N=10; 
M = 2*N; M2 = 2*M; k = [-M+1:1:M-1]';%M2 = no. of sampling points. 
L = sqrt(N/sqrt(2));%Optimal choice of L. 
theta = k*pi/M; t = L*tan(theta/2);%Variables theta and t. 
f = exp(-t.^2).*(L^2+t.^2);f=[0;f];%Function to be transformed. 
a = real(fft(fftshift(f)))/M2;%Coefficients of transform. 
a = flipud(a(2:N+1));%Reorder coefficients. 
Z = (L+i*z)./(L-i*z); p = polyval(a,Z);%Polynomial evaluation. 
f = 2*p./(L-i*z).^2+(1/sqrt(pi))./(L-i*z); %Evaluate w(z). 

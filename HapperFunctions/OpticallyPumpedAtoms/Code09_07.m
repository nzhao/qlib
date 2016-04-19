% Code01_07  %atomic properties
% Code09_04  %cycling transition matrices
% Code09_05  %compactification
% Code09_06  %compactification
Nuu=flat(tV(:,:,1)'*tV(:,:,1))/(i*Gpg*hbar);%self coupling up 
Ndd=flat(tV(:,:,2)'*tV(:,:,2))/(i*Gpg*hbar);%self coupling down 
Nnw=-Asge*kron(conj(tV(:,:,1)),tV(:,:,1))/(i*hbar*Gpg);%nw 
Nse=-Asge*kron(conj(tV(:,:,2)),tV(:,:,2))/(i*hbar*Gpg);%se 
Nne=-Asge*kron(conj(tV(:,:,2)),tV(:,:,1))/(i*hbar*Gpg);%ne 
Nsw=-Asge*kron(conj(tV(:,:,1)),tV(:,:,2))/(i*hbar*Gpg);%se 
Nnn=flat(tV(:,:,2)'*tV(:,:,1))/(i*Gpg*hbar);%nn 
Nss=flat(tV(:,:,1)'*tV(:,:,2))/(i*Gpg*hbar);%ss 

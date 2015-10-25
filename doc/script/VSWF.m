%% Vector Spherical Wavefunctions
% Vector spherical wavefunctions (VSWFs) are a basic building-blocks in the  theory
% of optical scattering on nano-particles. Although the VSWFs have very
% beautiful analytical properties, their definitions are different in
% different references and code implementations. In the following, we
% compare and summarize the definitions of VSWFs and related special functions
% (e.g., Legendre polynomials and spherical harmonics) in (i) Matlab(R) and Mathematica(R)
% build-in functions, (ii) Zhu-Xi Wang, textbook 'Introduction of Special Functions',
% (iii) M. I. Mishchenko, et. al., 'Scattering, Absorption and Emission of
% Light by Small Particles', (iv) Optical tweezers toolbox (OTT) and (v) Prof. Zhi-Fang Lin's note.

%% Legendre Polynomials
% * In Matlab(R), Legendre Polynomials $P_n(x)$ for $x\in [-1, 1]$ and positive integer $n$ are defined as
%
% $$ P_n(x) = \frac{1}{2^n n!}\frac{d}{d x} (x^2-1)^n $$
%
% and, for $0\le m \le n$, the associated Legendre functions are
%
% $$ P_n^m(x) = (-1)^m (1-x^2)^{m/2} \frac{d^m}{dx^m}P_n(x). $$
%
% With this definition, Legendre Polynomials are normalized to 
%
% $$ \int_{-1}^1 P_n^m(x)P_{n'}^{m'}(x)dx = \frac{2}{2n+1}
% \frac{(n+m)!}{(n-m)!}\delta_{mm'}\delta_{nn'} $$
%
% The same definitions are also used in Mathematica(R), Mishchenko's book,
% and Wang's book. Here is an example in Matlab(R):

pmn=legendre(3, -1:0.01:1);
plot(-1:0.01:1, pmn);

% normalization
n=3;
[xlist, wlist]=model.math.misc.lgwt(50, -1, 1);
inte=(legendre(n, xlist).^2) * wlist;
norm=zeros(n+1,1);
for m=0:n
    norm(m+1)=2.0/(2*n+1) * factorial(n+m)/factorial(n-m);
end
disp([inte, norm])

%%
% * Prof. Lin's note uses a different convention in $P_n^m(x)$, where
% $(-1)^m$ is omitted, i.e.,
%
% $$ \tilde{P}_n^m(x) = (1-x^2)^{m/2} \frac{d^m}{dx^m}P_n(x). $$
%
%%
% * OTT uses a different normalization convention, where $P_n^m(x)$ are normalized to
% a constant $1/(2\pi)$:
%
% $$ \hat{P}_n^m(x)= \sqrt{\frac{2n+1}{4\pi}\frac{(n-m)!}{(n+m)!}}\tilde{P}_n^m(x).
% $$
% 
% Note that, essentially, OTT uses the same sign convention as Lin's note
% (i.e., omitting the $(-1)^m$ factor).
%
% In addition, OTT uses the polar angle $\theta$ as the argument, instead of $x=\cos\theta$.

disp([ott13.legendrerow(n, pi/3) ,legendre(n, cos(pi/3), 'norm')/sqrt(2*pi)] );

[tlist, wlist]=model.math.misc.lgwt(50, 0, pi);
disp((ott13.legendrerow(n, tlist).^2) * (wlist.*sin(tlist)) * 2*pi);

%%
% * Legendre polynomials with negative $m$ are defined as (see e.g., Wang's book and Lin's Note)
%
% $$ P_n^{-\vert m\vert} (x)= (-1)^m \frac{(n-\vert m)!}{(n+\vert m)!} P_n^{\vert m \vert}(x) $$
%
% However, Matlab(R) and OTT do not export Legendre polynomials directly
% (only $m=0\dots n$ are exported). Legendre polynomials with negative $m$
% are used when computing Spherical harmonic functions $Y_{n,m}(\theta,
% \phi)$ in OTT.

%% Spherical Harmonic Functions
% Spherical harmonic functions $Y_{n, m}(\theta, \phi)$ are defined as (Wang's book and Mathematica(R))
%
% $$Y_{n,m}(\theta, \phi)=\sqrt{\frac{2n+1}{4\pi}\frac{(n-m)!}{(n+m)!}}
% P_n^m(\cos\theta) e^{i m \phi}. $$
%
% Matlab does not provide a direct implementation of sphercial harmonic
% functions, while Mathematica(R) and OTT do

n=5; m=3;
disp(ott13.spharm(n, m, pi/3, pi/5));
disp(ott13.spharm(n, -m, pi/3, pi/5));
n=5; m=2;
disp(ott13.spharm(n, m, pi/3, pi/5));
disp(ott13.spharm(n, -m, pi/3, pi/5));

%%
% We checked that, OTT result differs to the Mathematica result by a
% factor of $(-1)^m$ due to the different sign convention of Legendre
% polynomials.
%
% In both Mathematica(R) and OTT implementations, the Spherical harmonics
% are normalized to unity (see Wang's book), i.e.,
%
% $$ \int_0^{\pi}d\theta\int_0^{2\pi}d\phi \sin\theta Y_{n, m}(\theta, \phi)Y_{n',
% m'}^{*}(\theta, \phi) = \delta_{n, n'}\delta_{m, m'}, $$
%
% and the following relation is satisfied (see Wang's book)
%
% $$ Y_{n,-m}(\theta, \phi)= (-1)^m Y_{n, m}^{*}(\theta, \phi). $$
%
%% Spherical Bessel and Spherical Hankel Functions
% Spherical Bessel and Spherical Hankel functions are used to describe the
% wave propagation in the radial direction.
%
% * Spherical Bessel function of the first kind $j_n(r)$ and second kind $y_n(r)$ 
% are indeed the corresponding Bessel function $J_n(r)$ and $Y_n(r)$ of half-integer order
%
% $$ j_n(r)= \sqrt{\frac{\pi}{2r}}J_{n+1/2}(r). $$
%
% $$ y_n(r)= \sqrt{\frac{\pi}{2r}}Y_{n+1/2}(r). $$
%
% $j_n(r)$ has fintite value at $r=0$, while $y_n(r)$ diverges at $r=0$. 
%
% Matlab(R) does not provide a direct implementation of $j_n(r)$. OTT and
% Mathematica(R) have identical implementations.
%
plot(0:0.1:10, [ott13.sbesselj(0, 0:0.1:10)'; ...
                ott13.sbesselj(1, 0:0.1:10)'; ...
                ott13.sbesselj(2, 0:0.1:10)']);
%%
% * Spherical Hankel functions of the first kind $h^{(1)}_n(r)$ and the second kind $h^{(2)}_n(r)$ are 
% half-integer order Hankel functions $H^{(1)}_n(r)$ and $H^{(2)}_n(r)$.
% 
% $$ h^{(1,2)}(r) = \sqrt{\frac{\pi}{2r}} H^{(1,2)}(r) = j_n(r) \pm i
% y_n(r). $$
%
% Matlab(R) does not provide a direct implementation of $h^{(1,2)}_n(x)$. OTT and
% Mathematica(R) have identical implementations.
%
%% Vector Spherical Wavefunctions
% With Spherical harmonic function $Y_{n,m}(\theta,\phi)$, spherical Bessel
% functions $j_n(r)$ and spherical Hankel functions $h_n^{(1,2)}(r)$, we
% can further define vector spherical wavefunctions 
% $\mathbf{M}^{(q)}_{n,m}(kr, \theta, \phi)$ and 
% $\mathbf{N}^{(q)}_{n,m}(kr, \theta, \phi)$.
%
% Before VSWFs, we first define vector spherical harmonics (VSHs)
% $\mathbf{B}(\theta, \phi)$, $\mathbf{C}(\theta, \phi)$, and $\mathbf{P}(\theta, \phi)$
%
% $$ \mathbf{B}_{n,m}(\theta, \phi)=r\nabla Y_{n, m}(\theta, \phi) =
% \hat{\mathbf{r}}\times \mathbf{C}_{n,m}(\theta,\phi)
% =\left(\tau_{n,m}(\theta) \hat{\mathbf{e}}_{\theta}+i\pi_{n,m}(\theta)\hat{\mathbf{e}}_{\phi}\right)e^{im\phi}, $$
%
% $$ \mathbf{C}_{n,m}(\theta, \phi)=\nabla\times(\mathbf{r}Y_{n, m}(\theta, \phi)) =
% \mathbf{B}_{n,m}(\theta,\phi) \times  \hat{\mathbf{r}}
% =\left(i\pi_{n,m}(\theta) \hat{\mathbf{e}}_{\theta}-\tau_{n,m}(\theta)\hat{\mathbf{e}}_{\phi}\right)e^{im\phi}, $$
%
% $$ \mathbf{P}_{n,m}(\theta, \phi)=\hat{\mathbf{r}} Y_{n, m}(\theta,
% \phi),$$
%
% where $\pi_{n, m}(\theta)$ and $\tau_{n, m}(\theta)$ are
%
% $$ \pi_{n, m}(\theta)=\frac{m}{\sin\theta}P_n^m(\theta), $$
%
% $$ \tau_{n, m}(\theta)=\frac{d}{d\theta}P_n^m(\theta), $$














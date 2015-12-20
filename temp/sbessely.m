function [yn] = sbessely(n,kr)
% sbessely - second spherical bessel function yn(kr)
% yn(kr) = sqrt(pi/2kr) yn+0.5(kr)

kr=kr(:);
n=n(:);
[yn] = bessely(n'+1/2,kr);
[n,kr]=meshgrid(n,kr);

% yn = sqrt(pi./(2*kr)) .* yn;
small_args = find( abs(kr) < 1e-15 );
not_small_args = find( ~(abs(kr) < 1e-15) );

if length(kr) == 1 & abs(kr) < 1e-15
    yn = -1./kr.^(n+1) .* prod(1:2:(2*n-1));
elseif length(kr) == 1 & ~(abs(kr) < 1e-15)
    yn = sqrt(pi./(2*kr)) .* yn;
elseif length(n) == 1
    yn(not_small_args) = ...
        sqrt(pi./(2*kr(not_small_args))) .* yn(not_small_args);
    yn(small_args) = -1./kr(small_args).^(n+1) .* prod(1:2:(2*n-1));
else % both n and kr are vectors
    yn(not_small_args) = ...
        sqrt(pi./(2*kr(not_small_args))) .* yn(not_small_args);
    yn(small_args) = -1./kr(small_args).^(n(small_args)+1) .* ...
        prod(1:2:(2*n(small_args)-1));
end

return

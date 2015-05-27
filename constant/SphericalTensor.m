function [ ist ] = SphericalTensor(dim)
%Generates sparse irreducible spherical tensor matrices

    if dim==2
        ist=cell(dim^2);
        ist{1}=[1,0;0,1]/sqrt(2);  ist{2}=[1 0; 0 -1]/sqrt(2);ist{3}=[0 1; 0 0]; ist{4}=[0 0; 1 0];
    elseif dim==3
        ist=cell(dim^2);
        ist{1}=[1,0,0;0,1,0;0,0,1]/sqrt(3);ist{2}=[1,0,0;0,0,0;0,0,-1]/sqrt(2);ist{3}=[1,0,0;0,-2,0;0,0,1]/sqrt(6);
        ist{4}=(Sx(dim)+1i*Sy(dim))/2; ist{5}=(Sx(dim)-1i*Sy(dim))/2;
        ist{6}=(Sx(dim)*Sz(dim)+Sz(dim)*Sx(dim)+1i*(Sy(dim)*Sz(dim)+Sz(dim)*Sy(dim)))/2;
        ist{7}=(Sx(dim)*Sz(dim)+Sz(dim)*Sx(dim)-1i*(Sy(dim)*Sz(dim)+Sz(dim)*Sy(dim)))/2;
        ist{8}=(Sx(dim)*Sx(dim)-Sy(dim)*Sy(dim)+1i*(Sx(dim)*Sy(dim)+Sy(dim)*Sx(dim)))/2;
        ist{9}=(Sx(dim)*Sx(dim)-Sy(dim)*Sy(dim)-1i*(Sx(dim)*Sy(dim)+Sy(dim)*Sx(dim)))/2;
    else 
        error('Irreducible spherical tensor whoes dimension is higher than 3 not implemented.');
    end 


end


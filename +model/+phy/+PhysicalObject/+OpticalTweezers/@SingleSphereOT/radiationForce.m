function force = radiationForce( obj, path )
%RADIATIONFORCE Summary of this function goes here
%   Detailed explanation goes here
    path=path/obj.beam.focBeam.wavelength;
    nmax=obj.Nmax;
    Rx = ott13.z_rotation_matrix(pi/2,0);
    Dx = ott13.wigner_rotation_matrix(nmax,Rx);
    Ry = ott13.z_rotation_matrix(pi/2,pi/2);
    Dy = ott13.wigner_rotation_matrix(nmax,Ry);


    force=zeros(3, size(path, 2));
    for ii = 1:size(path,2)
        rVect=path(:, ii);
        [p, q, a2, b2]=obj.getPQ(rVect);

        n=obj.idx_n; m=obj.idx_m;
        fx = ott13.force_z(n,m,Dx*a2,Dx*b2,Dx*p,Dx*q); %Dx makes the z-force calculation the x-force calculation.
        fy = ott13.force_z(n,m,Dy*a2,Dy*b2,Dy*p,Dy*q); %Dy makes the z-force calculation the z-force calculation.
        fz = ott13.force_z(n,m,a2,b2,p,q); 
        force(:, ii)=[fx, fy, fz]';
    end
end


function uHg = gsHamiltonian( obj, magB )
    %GSHAMILTONIAN Summary of this function goes here
    %   Detailed explanation goes her

    nuc=obj.nSpin;  ele=obj.gSpin;

<<<<<<< HEAD
    gI=nuc.dim; gammaN=nuc.gamma; %in unit rad/s/T
    gS=ele.dim; gammaG=ele.gamma; %in unit rad/s/T
    
    Ag=obj.parameters.hf_gs*2.0*pi; %in unit 2pi* MHz
=======
    gI=nuc.dim; gammaN=nuc.gamma; %gammaN's unit is Hz/T
    gS=ele.dim; gammaG=ele.gamma;%gammaG's unit is Hz/T
    
    Ag=obj.parameters.hf_gs;
>>>>>>> master

    sIj(:,:,1)=nuc.sx;
    sIj(:,:,2)=nuc.sy;
    sIj(:,:,3)=nuc.sz;  

    sSj(:,:,1)=ele.sx;
    sSj(:,:,2)=ele.sy;
    sSj(:,:,3)=ele.sz;
    
    %operators in uncoupled space
    gg=obj.dimG;
    aIjg=zeros(gg,gg);
    gSj=zeros(gg,gg);
    umug=zeros(gg,gg);
    for k=1:3
        aIjg(:,:,k)=kron(sIj(:,:,k),eye(gS));
        gSj(:,:,k)=kron(eye(gI),sSj(:,:,k));
    end

    for k=1:3;% uncoupled magnetic moment operators
<<<<<<< HEAD
        umug(:,:,k)=-gammaG*gSj(:,:,k)-gammaN*aIjg(:,:,k);
    end
    uIS=matdot(aIjg,gSj);%uncoupled I.S
    uHg=Ag*uIS + umug(:,:,3)*magB*1e-6;%uncoupled Hamiltonian, in [2pi*MHz]
=======
        umug(:,:,k)=gammaG*gSj(:,:,k)+gammaN*aIjg(:,:,k);
    end
    uIS=matdot(aIjg,gSj);%uncoupled I.S
    uHg=Ag*uIS-umug(:,:,3)*magB*1e-6;%uncoupled Hamiltonian, in [MHz]
>>>>>>> master
end


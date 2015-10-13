function uHg = gsHamiltonian( obj, magB )
    %GSHAMILTONIAN Summary of this function goes here
    %   Detailed explanation goes here

    %constant;
    S=obj.parameters.spin_S;
    I=obj.parameters.spin_I;

    gI=2*I+1; gS=2*S+1; 
    LgS=obj.parameters.LgS;% Lande g-value of S1/2 state
    muI=obj.parameters.mu_I*muN;%nuclear moment in erg/G
    Ag=obj.parameters.hf_gs*2.0*pi;

    sIp=diag(sqrt((1:2*I).*(2*I:-1:1)),1);
    sIj(:,:,1)=(sIp+sIp')/2;
    sIj(:,:,2)=(sIp-sIp')/(2*1j);
    sIj(:,:,3)=diag(I:-1:-I);
    sSp=diag(sqrt((1:2*S).*(2*S:-1:1)),1);
    sSj(:,:,1)=(sSp+sSp')/2;
    sSj(:,:,2)=(sSp-sSp')/(2*1j);
    sSj(:,:,3)=diag(S:-1:-S);
    %operators in uncoupled space
    for k=1:3
        aIjg(:,:,k)=kron(sIj(:,:,k),eye(gS));
        gSj(:,:,k)=kron(eye(gI),sSj(:,:,k));
    end

    for k=1:3;% uncoupled magnetic moment operators
        umug(:,:,k)=-LgS*muB*gSj(:,:,k)+(muI/(I+eps))*aIjg(:,:,k);
    end
    uIS=matdot(aIjg,gSj);%uncoupled I.S
    uHg=Ag*uIS-umug(:,:,3)*magB*1e-6/hbar;%uncoupled Hamiltonian, in [2pi*MHz]
end


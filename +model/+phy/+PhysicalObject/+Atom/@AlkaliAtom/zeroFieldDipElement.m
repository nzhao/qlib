function z = zeroFieldDipElement( obj, L1,L,J1,J,F1,F,MF1,MF,q )
%zeroFieldDipElement Summary of this function goes here

    S=obj.parameters.spin_S;
    I=obj.parameters.spin_I;
    
    z=0;
    z=z+(-1)^(1+L1+S+J+J1+I-MF1)*sqrt((2*J+1)*(2*J1+1)*(2*F+1)*(2*F1+1))*...
     sixj(L1,J1,S,J,L,1)*sixj(J1,F1,I,F,J,1)*threej(F,MF,1,q,F1,-MF1);%It is come from page55 (4.33) of Laser Cooling and Trapping book.                       

end


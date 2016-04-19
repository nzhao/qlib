%Code02_01 %constants, atomic properties
%Code03_01 %uncoupled spin matrices
%Code03_02 %energy basis states, unitary matrices
f=(I+S:-1:abs(I-S))';
C=(f.*(f+1)-I*(I+1)-S*(S+1))/2; Egf=Ag*C;%ground state
f=(I+J:-1:abs(I-J))';
C=(f.*(f+1)-I*(I+1)-J*(J+1))/2; Eef=Ae*C;%excited state
if I>.5&J>.5
    Eef=Eef+Be*(3*C.^2+1.5*C-I*(I+1)*J*(J+1))/(2*I*(2*I-1)*J*(2*J-1));
end

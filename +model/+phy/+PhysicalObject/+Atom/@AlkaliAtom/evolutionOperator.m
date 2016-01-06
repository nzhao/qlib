function [G,G0,G1,G2,dGdw]=evolutionOperator(obj,Dnu,J,magB)
Dw=2*pi*1e6* Dnu; 
G0=obj.darkMatrix(J,magB);
G1=obj.pumpingMatrix(J,magB);
G2=obj.collisionsMatrix(J);
dGdw=obj.matrix(J,magB);
G=G0+G1+G2+Dw*dGdw;%total damping matrix 

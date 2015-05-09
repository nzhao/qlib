classdef DipolarInteraction < model.phy.SpinInteraction.AbstractSpinInteraction
    %DIPOLARINTERACTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        axis
    end
    
    methods
        function obj=DipolarInteraction(spin_collection, para, iter)
            if nargin < 3
                iter=model.phy.SpinCollection.Iterator.PairSpinIterator(spin_collection);
            end
            obj@model.phy.SpinInteraction.AbstractSpinInteraction(para, iter);
            
            try 
                obj.axis=para.axis;
            catch
                obj.axis=eye(3);
            end
            obj.nbody=2;
        end
        
        function coeff=calculate_coeff(obj, spins)
            spin1=spins{1}; spin2=spins{2};

            coord1=spin1.coordinate; gamma1=spin1.gamma;
            coord2=spin2.coordinate; gamma2=spin2.gamma;

            vect=coord2-coord1;
            distance=norm(vect);
            ort=vect/distance;

            % dipolar interaction strength
            A=hbar*mu0*gamma1*gamma2/(4*pi*(distance*1e-10)^3);

            % the dipolar coupling matrix
            coeff_mat=A*...
                [1-3*ort(1)*ort(1)   -3*ort(1)*ort(2)   -3*ort(1)*ort(3);
                  -3*ort(2)*ort(1)  1-3*ort(2)*ort(2)   -3*ort(2)*ort(3);
                  -3*ort(3)*ort(1)   -3*ort(3)*ort(2)  1-3*ort(3)*ort(3)];
            coeff = obj.axis * coeff_mat * obj.axis';
        end
        
        function mat=calculate_matrix(obj)
            spins=obj.iter.currentItem();
            spin1=spins{1}; spin2=spins{2};
            dip=obj.calculate_coeff(spins);
            mat= dip(1,1)*kron(spin1.sx,spin2.sx)...
                +dip(1,2)*kron(spin1.sx,spin2.sy)...
                +dip(1,3)*kron(spin1.sx,spin2.sz)...
                +dip(2,1)*kron(spin1.sy,spin2.sx)...
                +dip(2,2)*kron(spin1.sy,spin2.sy)...
                +dip(2,3)*kron(spin1.sy,spin2.sz)...
                +dip(3,1)*kron(spin1.sz,spin2.sx)...
                +dip(3,2)*kron(spin1.sz,spin2.sy)...
                +dip(3,3)*kron(spin1.sz,spin2.sz);
        end
    end
    
end


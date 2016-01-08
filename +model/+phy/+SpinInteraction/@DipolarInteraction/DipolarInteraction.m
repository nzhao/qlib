classdef DipolarInteraction < model.phy.SpinInteraction.AbstractSpinInteraction
    %DIPOLARINTERACTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        axis
    end
    
    methods
        function obj=DipolarInteraction(spin_collection, varargin)
            para=struct;
            iter_class=@model.phy.SpinCollection.Iterator.PairSpinIterator;
            for k=1:length(varargin)
                if isa(varargin{k}, 'struct')
                    para=varargin{k};
                elseif isa(varargin{k}, 'model.phy.SpinCollection.SpinCollectionIterator')
                    iter_class=varargin{k};
                end
            end
            iter=iter_class(spin_collection);
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
        
        function skp=single_skp_term(obj)
            spins=obj.iter.currentItem();
            idx=obj.iter.currentIndex();
            spin1=spins{1}; spin2=spins{2};
            dip=obj.calculate_coeff(spins);
            
            mat1=spin1.sx; mat2=dip(1,1)*spin2.sx + dip(1,2)*spin2.sy +dip(1,3)*spin2.sz;
            xTerm=obj.kron_prod(1.0, idx, {mat1, mat2});
            
            mat1=spin1.sy; mat2=dip(2,1)*spin2.sx + dip(2,2)*spin2.sy +dip(2,3)*spin2.sz;
            yTerm=obj.kron_prod(1.0, idx, {mat1, mat2});
            
            mat1=spin1.sz; mat2=dip(3,1)*spin2.sx + dip(3,2)*spin2.sy +dip(3,3)*spin2.sz;
            zTerm=obj.kron_prod(1.0, idx, {mat1, mat2});
            
            skp=xTerm+yTerm+zTerm;
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
        
        function dataCell=data_cell(obj)
            nPair=obj.iter.getLength;
            nTerms=nPair*9;
            dataCell=cell(1, nTerms);
            
            obj.iter.setCursor(1);
            for ii=1:nPair
                spins=obj.iter.currentItem();
                spin_idx=obj.iter.currentIndex();
                spin1=spins{1}; spin2=spins{2};
                index1=spin_idx(1); index2=spin_idx(2);
                
                dip=obj.calculate_coeff(spins);
                
                dataCell{(ii-1)*9+1}={dip(1,1), obj.nbody, ...
                    index1, spin1.dim, reshape(spin1.sx, [], 1), ...
                    index2, spin2.dim, reshape(spin2.sx, [], 1)
                    };
                dataCell{(ii-1)*9+2}={dip(1,2), obj.nbody, ...
                    index1, spin1.dim, reshape(spin1.sx, [], 1), ...
                    index2, spin2.dim, reshape(spin2.sy, [], 1)
                    };
                dataCell{(ii-1)*9+3}={dip(1,3), obj.nbody, ...
                    index1, spin1.dim, reshape(spin1.sx, [], 1), ...
                    index2, spin2.dim, reshape(spin2.sz, [], 1)
                    };
                dataCell{(ii-1)*9+4}={dip(2,1), obj.nbody, ...
                    index1, spin1.dim, reshape(spin1.sy, [], 1), ...
                    index2, spin2.dim, reshape(spin2.sx, [], 1)
                    };
                dataCell{(ii-1)*9+5}={dip(2,2), obj.nbody, ...
                    index1, spin1.dim, reshape(spin1.sy, [], 1), ...
                    index2, spin2.dim, reshape(spin2.sy, [], 1)
                    };
                dataCell{(ii-1)*9+6}={dip(2,3), obj.nbody, ...
                    index1, spin1.dim, reshape(spin1.sy, [], 1), ...
                    index2, spin2.dim, reshape(spin2.sz, [], 1)
                    };
                dataCell{(ii-1)*9+7}={dip(3,1), obj.nbody, ...
                    index1, spin1.dim, reshape(spin1.sz, [], 1), ...
                    index2, spin2.dim, reshape(spin2.sx, [], 1)
                    };
                dataCell{(ii-1)*9+8}={dip(3,2), obj.nbody, ...
                    index1, spin1.dim, reshape(spin1.sz, [], 1), ...
                    index2, spin2.dim, reshape(spin2.sy, [], 1)
                    };
                dataCell{(ii-1)*9+9}={dip(3,3), obj.nbody, ...
                    index1, spin1.dim, reshape(spin1.sz, [], 1), ...
                    index2, spin2.dim, reshape(spin2.sz, [], 1)
                    };
                obj.iter.nextItem;
            end
        end
    end
    
end


classdef Spin < model.phy.PhysicalObject.PhysicalObject
    %SPIN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        gamma
        ZFS=0;% zero field splitting result from the inhomogeneous electric field ,i.e., electric quadrupole interaction, ZFS for NV etc
        eta=0;   %asymmetry parameter of ZFS
        principle_axis=[0,0,1];%the orientation of the principal axis
        
        coordinate=[];
        local_field=[0 0 0]';
        qAxis=[1 0 0; 0 1 0; 0 0 1];
        
        S
        S2
    end
    
    methods
        function obj = Spin(name, coord)
            obj.name=name;
            [obj.dim, obj.gamma] = model.phy.data.NMRData.get_spin(name);
            if nargin > 1
                obj.coordinate=coord;
            end
            
            obj.S= 0.5*(obj.dim-1);
            obj.S2= obj.S*(obj.S+1);
        end
        
        function xmat=sx(obj)
            xmat=Sx(obj.dim);
        end
        
        function ymat=sy(obj)
            ymat=Sy(obj.dim);
        end
        
        function zmat=sz(obj)
            zmat=Sz(obj.dim);
        end
        
        function projMat=p(obj, k)
            projMat=zeros(obj.dim);
            projMat(k, k)=1;
        end
        
        function generalMat=mat(obj, m)
            if length(m)==obj.dim
                generalMat=m;
            else
                error('dimension mismatch. matrix_dim=%d is assigned, but spin_dimension=%d is needed.', length(m), obj.dim);
            end
        end
        
        function expM=expMat(obj, m)
            if length(m)==obj.dim
                expM=expm(m);
            else
                error('dimension mismatch. matrix_dim=%d is assigned, but spin_dimension=%d is needed.', length(m), obj.dim);
            end
        end
        
        function mat=eigen(obj)
            hami=obj.selfHamiltonian();
            [mat, ~]=eig(full(hami.getMatrix));
        end
        
        function hami=selfHamiltonian(obj)
            import model.phy.SpinInteraction.ZeemanInteraction
            
            sc=model.phy.SpinCollection.SpinCollection();
            sc.spin_source = model.phy.SpinCollection.Strategy.FromSpinList({obj});
            sc.generate();

            hami=model.phy.QuantumOperator.SpinOperator.Hamiltonian(sc);
            hami.addInteraction( ZeemanInteraction(sc) );
            hami.generate_matrix();
        end
        
        function ISTmat=IST(obj,state) %irreducible spherical tensors
            basis=SphericalTensor(obj.dim);
            ISTmat=basis{state+1};
            
        end
        
    end
    
end


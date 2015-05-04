classdef Spin < phy.stuff.PhysicalObject
    %SPIN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        gamma
        chizz=0; %electric quadrupole interaction constant
        eta=0;   %asymmetry parameter
        coordinate=[];
        local_field=[0 0 0]';
        qAxis=[1 0 0; 0 1 0; 0 0 1];
        
        S
        S2
    end
    
    methods
        function obj = Spin(name, coord)
            obj.name=name;
            [obj.dim, obj.gamma, obj.chizz, obj.eta] = data.NMRData.get_spin(name);
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
        
        function ISTmat=IST(obj,state) %irreducible spherical tensors
            basis=SphericalTensor(obj.dim);
            ISTmat=basis{state+1};
            
        end
        
    end
    
end


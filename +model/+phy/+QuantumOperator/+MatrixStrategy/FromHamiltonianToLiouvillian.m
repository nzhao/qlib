classdef FromHamiltonianToLiouvillian < model.phy.QuantumOperator.MatrixStrategy
    %FROMHAMILTONIANTOLIOUVILLIAN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        hamiltonian
    end
    
    methods
        function obj=FromHamiltonianToLiouvillian(hami)
            obj.hamiltonian=hami;
        end
        
        function initialize(obj, lv)
            obj.hamiltonian.interaction_list=lv.interaction_list;
            obj.hamiltonian.generate_matrix();
            lv.dim=obj.hamiltonian.dim;
        end
        
        function matrix=calculate_matrix(obj)
            h_mat=obj.hamiltonian.matrix;
            h_dim=obj.hamiltonian.dim;
            matrix=kron(h_mat, speye(h_dim)) - kron(speye(h_dim), h_mat).';
        end        
    end
    
end


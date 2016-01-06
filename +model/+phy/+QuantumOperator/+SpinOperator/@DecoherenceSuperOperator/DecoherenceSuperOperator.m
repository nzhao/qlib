classdef DecoherenceSuperOperator < model.phy.QuantumOperator.MultiSpinSuperOperator
    %DECOHERENCESUPEROPERATOR generate a superoperator to describe the decoherence of the multi-spin system.
    % the total decoherence operator in the Liouville space is the summation of the decoherence operator 
    % for each single spin. But if the spin is not spin half, the corresponding decoherence operator is 
    % replaced by the zero matrix. 

    %   The decoherence operator of the single spin is of the Lindblad form:
    %  L rho = (1/2)*Gamma_vertical*[f(omega)+1](2sigma_{-}*rho*sigma_{+} - rho*sigma_{+}sigma_{-} - sigma_{+}sigma_{-}*rho)
    %          +(1/2)*Gamma_vertical*f(omega)*(2sigma_{+}*rho*sigma_{-} - rho*sigma_{-}sigma_{+} - sigma_{-}sigma_{+}*rho)
    %          +(1/2)*Gamma_parallel*[sigma_{z}*rho*sigma_{z} - rho]
    % where sigma is the Pauli operator of the spin, Gamma_vertical (Gamma_vertical) describe the vertical (parallel) coupling 
    % between the spin and its bath, omega is the Zeeman splitting of the spin, and f(omega)=1/[exp(hbar*omega/kT)] is the 
    % occupation number of the bosonic mode with frequency omega.
    
    
    properties
        decay_rate_list
        
    end
    
    methods
        function obj=DecoherenceSuperOperator(spin_collection,decay_rate_list)
            obj@model.phy.QuantumOperator.MultiSpinSuperOperator(spin_collection);
            obj.name='decoherence_super_operator';
            
            obj.decay_rate_list=decay_rate_list;
        end
        
        function generate_matrix(obj)
            obj.matrix=obj.calculate_matrix();
            obj.hasMatrix=1;
        end
    end
    
end


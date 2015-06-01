classdef SpinSecularApproximation < model.phy.SpinApproximation.AbstractSpinApproximation
    %SPINSECULARAPPROXIMATION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        original_matrix
        hamiltonian0
    end
    
    methods
        function obj=SpinSecularApproximation(spin_collection, hami0)
            obj.spin_collection=spin_collection;
            if nargin > 1
                obj.hamiltonian0=hami0;
            else
                obj.hamiltonian0=spin_collection.selfEigenOperator();
            end
        end
        function apply(obj, hamiltonian)
            obj.original_matrix=hamiltonian.getMatrix;
            
            hamiltonian.transform2selfEigenBases();

            hMatrix=hamiltonian.getMatrix();
            h0Matrix=obj.hamiltonian0.getMatrix();
            approx_mat=hMatrix-h0Matrix;
            
            dim=length(h0Matrix);
            diagVal=repmat(diag(h0Matrix), 1, dim);
            freqMat=abs(diagVal-diagVal');
            
            approx_mat(freqMat>eps)=0;
            hamiltonian.setMatrix(approx_mat);
            disp('Secular Approximation is applied.');
        end
    end
    
end


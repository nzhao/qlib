classdef AtomicStructure
    %ATOMICSTRUCTURE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        atom_species_num
    end
    
    methods (Static)
        function parameters=get_parameters(name)
            switch char(name)
                case '87Rb'
                    parameters.dim=8+8+16;
                    parameters.spin_S=0.5;
                    parameters.LgS=2.00231;% Lande g-value of S1/2 state

                    % fine-structure parameters
                    parameters.config='[Kr]5s';     %electron configuation
                    parameters.IP=4.1771;           %ionization potential in eV
                    parameters.lambda_D1=794.978;   %wave length of D1 transition in nm
                    parameters.lambda_D2=780.241;   %wave length of D2 transition in nm
                    parameters.delta_FS=237.60;     %Fine-structure splitting in cm^(-1)
                    parameters.tau_1=27.75;         %lifetime of P_1/2 states
                    parameters.tau_2=26.25;         %lifetime of P_3/2 states
                    parameters.osc_1=0.341;         %oscillator strength of P_1/2 stats
                    parameters.osc_2=0.695;         %oscillator strength of P_3/2 stats
                    
                    % hyperfine-structure parameters
                    parameters.abundance=0.2783;    %natural abundance
                    parameters.spin_I=3./2.;        %nuclear spin number
                    parameters.mu_I=2.75182;        %nuclear magnetic moment in [mu_N]
                    parameters.lamJ1=7800e-10;       %D2 wavelength in m when J=1.5
                    parameters.te1=25.5e-9;          %spontaneous P1/2 lifetime in s  J=1.5
                    parameters.lamJ2=7947e-10;        %D1 wavelength in m    J=0.5
                    parameters.te2=28.5e-9;          %spontaneous P1/2 lifetime in when J=0.5
                    parameters.hf_gs=3417.35;   %  hf coeff of ground state S_1/2 in MHz
                    parameters.hf_es1=406.12;       %hf coeff of excited state P_1/2 in MHz
                    parameters.hf_es2A=84.72;       %hf coeff_A of excited state P_3/2 state in MHz
                    parameters.hf_es2B=12.50;       %hf coeff_B of excited state P_3/2 state in MHz
                case '133Cs'
                    %
                otherwise
                        error('no atomic data.');
            end
        end
    end
    
end


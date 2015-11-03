classdef MediumData
    %MEDIUMDATA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        function medium = get_parameters(name)
            [eM, muM]=model.phy.data.MediumData.data(name);
            medium.name=name;
            medium.eps=eM;
            medium.mu=muM;
            medium.n=sqrt(eM*muM);
            medium.v=c_velocity/medium.n;
            medium.Z=sqrt(muM/eM)*Z0;            
        end
        
        function [epsilon_M, mu_M]=data(name)

            switch char(name)
                case 'vacuum'
                    epsilon_M = 1.0;
                    mu_M      = 1.0;
                case 'air'
                    epsilon_M = 1.000293;%air in 0 degree-C, 1 atm
                    mu_M      = 1.0;
                case 'water'
                    epsilon_M = 1.3330;
                    mu_M      = 1.0;
                case 'oil1.3'
                    epsilon_M = 1.3;
                    mu_M      = 1.0;
                case 'oil1.4'
                    epsilon_M = 1.4;
                    mu_M      = 1.0;
                case 'oil1.5'
                    epsilon_M = 1.5;
                    mu_M      = 1.0;
                case 'oil1.6'
                    epsilon_M = 1.6;
                    mu_M      = 1.0;
                case 'sillica'
                    epsilon_M = 1.46;
                    mu_M      = 1.0;
                otherwise
                    error([name ' - unknown medium.']);
            end
        end
    end

    
end


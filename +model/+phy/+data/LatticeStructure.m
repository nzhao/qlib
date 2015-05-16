classdef LatticeStructure
    %LATTICESTRUCTURE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods (Static)
        function latt = get_lattice_structure(name)
            switch char(name)
                case 'diamond'
                    cubic_length=3.57;%angstrom
                    latt.num_basis=3;
                    latt.const=cubic_length*ones(1,3);
                    latt.bas=eye(3);
                    
                    latt.num_shift=8;
                    latt.atoms={'13C', '13C', '13C', '13C'...
                                '13C', '13C', '13C', '13C'};
                    latt.shift=cubic_length*...
                        [0      0      0;   ...
                         1./4   1./4,  1./4;...
                         2./4,  2./4,  0;   ...
                         3./4,  3./4,  1./4;...
                         2./4,  0,     2./4;...
                         0,     2./4,  2./4;...
                         3./4,  1./4,  3./4;...
                         1./4,  3./4, 3 ./4]';
                    
                case '4H-SiC'
                    
                 %
                otherwise
                    error('lattice structure does not implemented.');
            end
        end
    end
    
end


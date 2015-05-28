classdef NMRData
    %NMRDATA Summary of this class goes here
    %   Detailed explanation goes here
    % the electic quadrupole coupling constant :e^2*q*Q/hbar (unit: rad/s)
    % the asymmetry parameter
    
    properties
        species_num
    end
    
    methods (Static)
        function [dim, gamma, chizz, eta] = get_spin(name)
             chizz=0;
             eta=0;
            switch char(name)
                case 'NVespin'
                    dim=3;
                    gamma=-1.760859708e11; 
                case 'J1/2'
                    dim=2;
                    gamma=-1.760859708e11; % CODATA 2013
                case 'J3/2'
                    dim=4;
                    gamma=-1.760859708e11; % CODATA 2013
                case 'E'  % Electron
                    dim=2;
                    gamma=-1.760859708e11; % CODATA 2013
                case 'N'  % Neutron
                    dim=2;
                    gamma=-1.83247181e8;   % http://dx.doi.org/10.1103/PhysRevC.63.037301
                case 'M'  % Muon
                    dim=2;
                    gamma=-8.51615503e8;   % CODATA 2010
                case 'P'  % Proton
                    dim=2;
                    gamma= 2.675222005e8;  % CODATA 2013
                case '1H'
                    dim=2;
                    gamma= 2.675222005e8;  % CODATA 2013
                case '2H'
                    dim=3;
                    gamma= 4.10662791e7;   % NMR Enc. 1996
                case '3H'
                    dim=2;
                    gamma= 2.85349779e8;   % NMR Enc. 1996
                case '3He'
                    dim=2;
                    gamma=-2.03801587e8;   % NMR Enc. 1996
                case '4He'
                    dim=1;
                    gamma=0;               % Spin 0 nucleus
                case '6Li'
                    dim=3;
                    gamma= 3.9371709e7;    % NMR Enc. 1996
                case '7Li'
                    dim=4;
                    gamma= 1.03977013e8;   % NMR Enc. 1996
                case '9Be'
                    dim=4;
                    gamma=-3.759666e7;     % NMR Enc. 1996
                case '10B'
                    dim=7;
                    gamma= 2.8746786e7;    % NMR Enc. 1996
                    chizz= 2*pi*2.96e6;   % PRB 72, 085307
                    eta= 0;
                case '11B'
                    dim=4;
                    gamma= 8.5847044e7;    % NMR Enc. 1996
                    chizz= 2*pi*2.9069e6;  % PRB 72, 085307 (2005).
                    eta=0;
                case '12C'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '13C'
                    dim=2;
                    gamma= 6.728284e7;     % NMR Enc. 1996
                case '14N'
                    dim=3;
                    gamma= 1.9337792e7;    % NMR Enc. 1996
                    chizz= 2*pi*0.14e6;    %Solid State Nuclear Magnetic Resonance 10, 241 (1998).
                    eta=0;
                case '15N'
                    dim=2;
                    gamma=-2.71261804e7;   % NMR Enc. 1996
                case '16O'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '17O'
                    dim=6;
                    gamma=-3.62808e7;      % NMR Enc. 1996
                case '18O'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '19F'
                    dim=2;
                    gamma= 2.518148e8;     % NMR Enc. 1996
                case '20Ne'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '21Ne'
                    dim=4;
                    gamma=-2.11308e7;      % NMR Enc. 1996
                case '22Ne'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '23Na'
                    dim=4;
                    gamma=7.0808493e7;     % NMR Enc. 1996
                case '24Mg'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '25Mg'
                    dim=6;
                    gamma=-1.63887e7;      % NMR Enc. 1996
                case '26Mg'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '27Al'
                    dim=6;
                    gamma=6.9762715e7;     % NMR Enc. 1996
                case '28Si'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '29Si'
                    dim=2;
                    gamma=-5.3190e7;       % NMR Enc. 1996
                case '30Si'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '31P'
                    dim=2;
                    gamma=10.8394e7;       % NMR Enc. 1996
                case '32S'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '33S'
                    dim=4;
                    gamma=2.055685e7;      % NMR Enc. 1996
                case '34S'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '36S'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '35Cl'
                    dim=4;
                    gamma=2.624198e7;      % NMR Enc. 1996
                case '37Cl'
                    dim=4;
                    gamma=2.184368e7;      % NMR Enc. 1996
                case '36Ar'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '38Ar'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '39Ar'
                    dim=8;
                    gamma=-1.78e7;         % Needs checking
                case '40Ar'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '39K'
                    dim=4;
                    gamma= 1.2500608e7;    % NMR Enc. 1996
                case '40K'
                    dim=9;
                    gamma=-1.5542854e7;    % NMR Enc. 1996
                case '41K'
                    dim=4;
                    gamma= 0.68606808e7;   % NMR Enc. 1996
                case '40Ca'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '41Ca'
                    dim=8;
                    gamma=-2.182305e7;     % http://dx.doi.org/10.1103/PhysRevC.63.037301
                case '42Ca'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '43Ca'
                    dim=8;
                    gamma=-1.803069e7;     % NMR Enc. 1996
                case '44Ca'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '45Sc'
                    dim=8;
                    gamma=6.5087973e7;     % NMR Enc. 1996
                case '46Ti'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '47Ti'
                    dim=6;
                    gamma=-1.5105e7;       % NMR Enc. 1996
                case '48Ti'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '49Ti'
                    dim=8;
                    gamma=-1.51095e7;      % NMR Enc. 1996
                case '50Ti'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '50V'
                    dim=13;
                    gamma=2.6706490e7;     % NMR Enc. 1996
                case '51V'
                    dim=8;
                    gamma=7.0455117e7;     % NMR Enc. 1996
                case '52Cr'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '53Cr'
                    dim=4;
                    gamma=-1.5152e7;       % NMR Enc. 1996
                case '54Cr'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '55Mn'
                    dim=6;
                    gamma=6.6452546e7;     % NMR Enc. 1996
                case '54Fe'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '56Fe'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '57Fe'
                    dim=2;
                    gamma=0.8680624e7;     % NMR Enc. 1996
                case '58Fe'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '59Co'
                    dim=8;
                    gamma=6.332e7;         % NMR Enc. 1996
                case '60Ni'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '61Ni'
                    dim=4;
                    gamma=-2.3948e7;       % NMR Enc. 1996
                case '62Ni'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '64Ni'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '63Cu'
                    dim=4;
                    gamma=7.1117890e7;     % NMR Enc. 1996
                case '65Cu'
                    dim=4;
                    gamma=7.60435e7;       % NMR Enc. 1996
                case '64Zn'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '66Zn'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '67Zn'
                    dim=6;
                    gamma=1.676688e7;      % NMR Enc. 1996
                case '68Zn'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '69Ga'
                    dim=4;
                    gamma=6.438855e7;      % NMR Enc. 1996
                case '71Ga'
                    dim=4;
                    gamma=8.181171e7;      % NMR Enc. 1996
                case '70Ge'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '72Ge'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '73Ge'
                    dim=10;
                    gamma=-0.9722881e7;    % NMR Enc. 1996
                case '74Ge'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '75As'
                    dim=4;
                    gamma=4.596163e7;      % NMR Enc. 1996
                case '74Se'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '76Se'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '77Se'
                    dim=2;
                    gamma=5.1253857e7;     % NMR Enc. 1996
                case '78Se'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '79Br'
                    dim=4;
                    gamma=6.725616e7;      % NMR Enc. 1996
                case '81Br'
                    dim=4;
                    gamma=7.249776e7;      % NMR Enc. 1996
                case '80Kr'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '82Kr'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '83Kr'
                    dim=10;
                    gamma=-1.03310e7;      % NMR Enc. 1996
                case '84Kr'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '86Kr'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '85Rb'
                    dim=6;
                    gamma=2.5927050e7;     % NMR Enc. 1996
                case '87Rb'
                    dim=4;
                    gamma=8.786400e7;      % NMR Enc. 1996
                case '84Sr'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '86Sr'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '87Sr'
                    dim=10;
                    gamma=-1.1639376e7;    % NMR Enc. 1996
                case '88Sr'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '89Y'
                    dim=2;
                    gamma=-1.3162791e7;    % NMR Enc. 1996
                case '90Zr'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '91Zr'
                    dim=6;
                    gamma=-2.49743e7;      % NMR Enc. 1996
                case '92Zr'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '94Zr'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '93Nb'
                    dim=10;
                    gamma=6.5674e7;        % NMR Enc. 1996
                case '92Mo'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '94Mo'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '95Mo'
                    dim=6;
                    gamma=-1.7514e7;       % Needs checking
                case '96Mo'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '97Mo'
                    dim=6;
                    gamma=-1.7884e7;       % Needs checking
                case '98Mo'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '99Tc'
                    dim=10;
                    gamma=6.0503e7;        % Needs checking
                case '96Ru'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '98Ru'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '99Ru'
                    dim=6;
                    gamma=-1.2286e7;       % Needs checking
                case '100Ru'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '101Ru'
                    dim=6;
                    gamma=-1.3773e7;       % Needs checking
                case '102Ru'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '104Ru'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '103Rh'
                    dim=2;
                    gamma=-0.8468e7;       % NMR Enc. 1996
                case '102Pd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '104Pd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '105Pd'
                    dim=6;
                    gamma=-1.2305e7;       % Needs checking
                case '106Pd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '108Pd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '110Pd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '107Ag'
                    dim=2;
                    gamma=-1.0889181e7;    % NMR Enc. 1996
                case '109Ag'
                    dim=2;
                    gamma=-1.2518634e7;    % NMR Enc. 1996
                case '106Cd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '108Cd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '110Cd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '111Cd'
                    dim=2;
                    gamma=-5.6983131e7;    % NMR Enc. 1996
                case '112Cd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '113Cd'
                    dim=2;
                    gamma=-5.9609153e7;    % NMR Enc. 1996
                case '114Cd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '116Cd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '113In'
                    dim=10;
                    gamma=5.8845e7;        % NMR Enc. 1996
                case '115In'
                    dim=10;
                    gamma=5.8972e7;        % NMR Enc. 1996
                case '112Sn'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '114Sn'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '115Sn'
                    dim=2;
                    gamma=-8.8013e7;       % NMR Enc. 1996
                case '116Sn'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '117Sn'
                    dim=2;
                    gamma=-9.58879e7;      % NMR Enc. 1996
                case '118Sn'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '119Sn'
                    dim=2;
                    gamma=-10.0317e7;      % NMR Enc. 1996
                case '120Sn'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '122Sn'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '124Sn'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '121Sb'
                    dim=6;
                    gamma=6.4435e7;        % NMR Enc. 1996
                case '123Sb'
                    dim=8;
                    gamma=3.4892e7;        % NMR Enc. 1996
                case '120Te'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '122Te'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '123Te' 
                    dim=2;
                    gamma=-7.059098e7;     % NMR Enc. 1996
                case '124Te'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '125Te'
                    dim=2;
                    gamma=-8.5108404e7;    % NMR Enc. 1996
                case '126Te'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '128Te'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '130Te'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '127I'
                    dim=6;
                    gamma=5.389573e7;      % NMR Enc. 1996
                case '124Xe'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '126Xe'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '128Xe'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '129Xe'
                    dim=2;
                    gamma=-7.452103e7;     % NMR Enc. 1996
                case '130Xe'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '131Xe'
                    dim=4;
                    gamma=2.209076e7;      % NMR Enc. 1996
                case '132Xe'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '134Xe'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '136Xe'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '133Cs'
                    dim=8;
                    gamma=3.5332539e7;     % NMR Enc. 1996
                case '130Ba'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '132Ba'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '134Ba'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '135Ba'
                    dim=4;
                    gamma=2.65750e7;       % NMR Enc. 1996
                case '136Ba'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '137Ba'
                    dim=4;
                    gamma=2.99295e7;       % NMR Enc. 1996
                case '138Ba'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '138La'
                    dim=11;
                    gamma=3.557239e7;      % NMR Enc. 1996
                case '139La'
                    dim=8;
                    gamma=3.8083318e7;     % NMR Enc. 1996
                case '136Ce'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '138Ce'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '139Ce'
                    dim=6;
                    gamma= 2.906e7;        % Needs checking
                case '140Ce'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '142Ce'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '141Pr'
                    dim=6;
                    gamma=8.1907e7;        % NMR Enc. 1996
                case '142Nd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '143Nd'
                    dim=8;
                    gamma=-1.457e7;        % NMR Enc. 1996
                case '144Nd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '145Nd'
                    dim=8;
                    gamma=-0.898e7;        % NMR Enc. 1996
                case '146Nd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '148Nd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '150Nd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '147Pm'
                    dim=8;
                    gamma= 3.613e7;        % NMR Enc. 1996
                case '144Sm'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '147Sm'
                    dim=8;
                    gamma=-1.115e7;        % NMR Enc. 1996
                case '148Sm'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '149Sm'
                    dim=8;
                    gamma=-0.9192e7;       % NMR Enc. 1996
                case '150Sm'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '152Sm'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '154Sm'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '151Eu'
                    dim=6;
                    gamma=6.6510e7;        % NMR Enc. 1996
                case '153Eu'
                    dim=6;
                    gamma=2.9369e7;        % NMR Enc. 1996
                case '152Gd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '154Gd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '155Gd'
                    dim=4;
                    gamma=-0.82132e7;      % NMR Enc. 1996
                case '156Gd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '157Gd'
                    dim=4;
                    gamma=-1.0769e7;       % NMR Enc. 1996
                case '158Gd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '160Gd'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '159Tb'
                    dim=4;
                    gamma=6.4306e7;        % Needs checking
                case '156Dy'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '158Dy'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '160Dy'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '161Dy'
                    dim=6;
                    gamma=-0.9201e7;       % NMR Enc. 1996
                case '162Dy'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '163Dy'
                    dim=6;
                    gamma=1.289e7;         % NMR Enc. 1996
                case '164Dy'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '165Ho'
                    dim=8;
                    gamma=5.710e7;         % NMR Enc. 1996
                case '162Er'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '164Er'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '166Er'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '167Er'
                    dim=8;
                    gamma=-0.77157e7;      % NMR Enc. 1996
                case '168Er'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '170Er'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '169Tm'
                    dim=2;
                    gamma=-2.218e7;        % NMR Enc. 1996
                case '168Yb'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '170Yb'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '171Yb'
                    dim=2;
                    gamma=4.7288e7;        % NMR Enc. 1996
                case '172Yb'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '173Yb'
                    dim=6;
                    gamma=-1.3025e7;       % NMR Enc. 1996
                case '174Yb'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '176Yb'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '175Lu'
                    dim=8;
                    gamma=3.0552e7;        % NMR Enc. 1996
                case '176Lu'
                    dim=15;
                    gamma=2.1684e7;        % NMR Enc. 1996
                case '174Hf'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '176Hf'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '177Hf'
                    dim=8;
                    gamma=1.086e7;         % NMR Enc. 1996
                case '178Hf'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '179Hf'
                    dim=10;
                    gamma=-0.6821e7;       % NMR Enc. 1996
                case '180Hf'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '180Ta'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '181Ta'
                    dim=8;
                    gamma=3.2438e7;        % NMR Enc. 1996
                case '180W'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '182W'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '183W'
                    dim=2;
                    gamma=1.1282403e7;     % NMR Enc. 1996
                case '184W'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '186W'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '185Re'
                    dim=6;
                    gamma=6.1057e7;        % NMR Enc. 1996
                case '187Re'
                    dim=6;
                    gamma=6.1682e7;        % NMR Enc. 1996
                case '184Os'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '186Os'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '187Os'
                    dim=2;
                    gamma=0.6192895e7;     % NMR Enc. 1996
                case '188Os'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '189Os'
                    dim=4;
                    gamma=2.10713e7;       % NMR Enc. 1996
                case '190Os'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '192Os'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '191Ir'
                    dim=4;
                    gamma=0.4812e7;        % NMR Enc. 1996
                case '193Ir'
                    dim=4;
                    gamma=0.5227e7;        % NMR Enc. 1996
                case '190Pt'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '192Pt'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '194Pt'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '195Pt'
                    dim=2;
                    gamma=5.8385e7;        % NMR Enc. 1996
                case '196Pt'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '198Pt'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '197Au'
                    dim=4;
                    gamma=0.473060e7;      % NMR Enc. 1996
                case '196Hg'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '198Hg'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '199Hg'
                    dim=2;
                    gamma=4.8457916e7;     % NMR Enc. 1996
                case '200Hg'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '201Hg'
                    dim=4;
                    gamma=-1.788769e7;     % NMR Enc. 1996
                case '202Hg'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '204Hg'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '203Tl'
                    dim=2;
                    gamma=15.5393338e7;    % NMR Enc. 1996
                case '205Tl'
                    dim=2;
                    gamma=15.6921808e7;    % NMR Enc. 1996
                case '204Pb'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '206Pb'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '207Pb'
                    dim=2;
                    gamma=5.58046e7;       % NMR Enc. 1996
                case '208Pb'
                    dim=1;        
                    gamma=0;               % Spin 0 nucleus
                case '209Bi'
                    dim=10;
                    gamma=4.3750e7;        % NMR Enc. 1996
                case '209Po'
                    dim=2;
                    gamma= 7.4e7;          % NMR Enc. 1996
                case '227Ac'
                    dim=4;
                    gamma= 3.5e7;          % NMR Enc. 1996
                case '229Th'
                    dim=6;
                    gamma= 0.40e7;         % NMR Enc. 1996
                case '231Pa'
                    dim=4;
                    gamma=3.21e7;          % NMR Enc. 1996
                case '235U'
                    dim=8;
                    gamma=-0.4926e7;       % Needs checking
                case '237Np'
                    dim=6;
                    gamma=3.1e7;           % NMR Enc. 1996
                case '239Pu'
                    dim=2; 
                    gamma=0.972e7;         % NMR Enc. 1996
                case '241Am' 
                    dim=6;
                    gamma=1.54e7;          % NMR Enc. 1996
                case '243Am' 
                    dim=6;
                    gamma=1.54e7;          % NMR Enc. 1996
                case '247Cm'
                    dim=10;
                    gamma=0.20e7;          % NMR Enc. 1996
                case {'210At', '222Rn', '223Fr', '226Ra', '247Bk', '251Cf', '252Es', '253Es', '257Fm', '258Md', '259No'}
                    error([name ' - no data available in the current NMR literature.']);
                otherwise
                    error([name ' - unknown isotope.']);
            end            
        end
    end
    
end


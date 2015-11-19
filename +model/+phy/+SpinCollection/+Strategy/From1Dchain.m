classdef From1Dchain < model.phy.SpinCollection.SpinCollectionStrategy
    %FROM1DCHAIN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        chainLen
        species
    end
    
    methods
        function obj=From1Dchain(chain_length, spin_species)
            obj.strategy_name = 'From1Dchain';
            obj.chainLen=chain_length;
            obj.species=spin_species;
        end
        
        function spin_list = generate_spin_collection(obj)
            import model.phy.PhysicalObject.Spin
            
            spin_list=cell(1,obj.chainLen);
            for ii=1:obj.chainLen
                name=obj.species; coord=(ii-1)*[1, 0, 0];
                spin_i=Spin(name, coord);
                spin_i.name=num2str(ii);
                spin_list{ii}=spin_i;
            end
        end
    end
    
end


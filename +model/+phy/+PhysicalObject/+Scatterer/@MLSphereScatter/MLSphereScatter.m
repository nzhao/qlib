classdef MLSphereScatter < model.phy.PhysicalObject.PhysicalObject
    %MLSPHERESCATTER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x=0
        y=0
        z=0
        Nlayer=1;
        %         scatter_medium; %default SiO2.
        scatter_medium_n; %default SiO2.
        radius;
    end
    
    methods
        function obj = MLSphereScatter(r_center,radius,medium)
            obj.x=r_center(1);
            obj.y=r_center(2);
            obj.z=r_center(3);
            obj.radius=radius;
            NLayer=length(radius);
            %             obj.scatter_medium=cell(1,NLayer);
            %             for ii=1:NLayer
            %             obj.scatter_medium{ii}=model.phy.data.MediumData.get_parameters(medium(ii));
            %             end
            obj.scatter_medium_n=zeros(1,NLayer);
            for ii=1:NLayer
                obj.scatter_medium_n(ii)=model.phy.data.MediumData.get_parameters(medium(ii)).n;
            end
        end
    end
    
end

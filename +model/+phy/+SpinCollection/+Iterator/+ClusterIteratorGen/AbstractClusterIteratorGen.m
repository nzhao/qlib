classdef AbstractClusterIteratorGen < handle
    %ABSTRACTCLUSTERITERATORGEN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        parameters
        spin_collection
        connection_matrix
        cluster_matrix
    end
    
    methods
        function obj=AbstractClusterIteratorGen(spin_collection, parameters)
            obj.spin_collection=spin_collection;
            obj.parameters=parameters;
        end
        
        function generate_connection_matrix(obj)
            disp('conmatrix_gen: building the connection matrix...');
            
            nspin=obj.spin_collection.getLength();
            cutoff=obj.parameters.cutoff;
            
            con_matrix=zeros(nspin);
            for m=1:nspin
               for n=1:m-1
                   coord1=obj.spin_collection.spin_list{m}.coordinate;
                   coord2=obj.spin_collection.spin_list{n}.coordinate;
                  dist=norm(coord1-coord2);
                  if dist<cutoff
                      con_matrix(m,n)=1;
                  end
               end
            end

            con_matrix=con_matrix+con_matrix';
            obj.connection_matrix=sparse(logical(con_matrix));
            disp('cluster_gen: connection matrix generated.');
        end

    end
    
    methods (Abstract)
        generate_clusters(obj)
    end
    
end


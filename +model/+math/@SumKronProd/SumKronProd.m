classdef SumKronProd < handle
    %SUMKRONPROD Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nProd
        kron_prod_cell
        
        domainsizes_matchQ=1
        rangesizes_matchQ=1
        
        rangesizes
        domainsizes
    end
    
    methods
        function obj=SumKronProd(prod_cell)
            obj.kron_prod_cell=prod_cell;
            obj.nProd=length(prod_cell);
            obj.match_test();
            
            if obj.rangesizes_matchQ
                obj.rangesizes=prod_cell{1}.rangesizes;
            end
            
            if obj.domainsizes_matchQ
                obj.domainsizes=prod_cell{1}.domainsizes;
            end
        end
        
        function append(obj, prod)
            obj.kron_prod_cell{obj.nProd+1}=prod;
            obj.nProd=obj.nProd+1;
            obj.match_test();
        end
        
        function join(obj, prod_cell)
            obj.kron_prod_cell = [obj.kron_prod_cell, prod_cell];
            obj.nProd=obj.nProd+1;
            obj.match_test();
        end

        function match_test(obj)
            for ii=1:obj.nProd-1
                prod1=obj.kron_prod_cell{ii}; prod2=obj.kron_prod_cell{ii+1}; 

                if obj.domainsizes_matchQ
                    try 
                        obj.domainsizes_matchQ=all(prod1.domainsizes==prod2.domainsizes);
                    catch
                        obj.domainsizes_matchQ=0;
                    end
                end
                
                if obj.rangesizes_matchQ
                    try 
                        obj.rangesizes_matchQ=all(prod1.rangesizes==prod2.rangesizes);
                    catch
                        obj.rangesizes_matchQ=0;
                    end
                end
                
                if ~ all(size(prod1)==size(prod2))
                    error('size does not match: size(prod%d) != size(prod%d)', ii, ii+1);
                end
            end
        end
    end
    
end


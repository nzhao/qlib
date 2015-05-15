classdef DynamicsRender < view.SolutionRender.AbstractSolutionRender
    %DYNAMICSRENDER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=DynamicsRender(sol)
            obj@view.SolutionRender.AbstractSolutionRender(sol);
        end
        
        function results=get_result(obj)
            sol=obj.solution;
            [nObs, mTimeLength]=size(sol.observable_values);
            res_data=mat2cell(sol.observable_values, ones(1, nObs), mTimeLength);
            results=containers.Map(sol.observable_keys, res_data);
            results('time')=sol.time_list;
        end
        
        function plt=plot(obj, name, varargin)
            res=obj.get_result();
            
            x=res('time');
            y=res(name);
            
            style='ro-';
            for k=1:length(varargin)
                switch class(varargin{k})
                    case 'function_handle'
                        f=varargin{k};
                        y=f(y);
                    case 'char'
                        style=varargin{k};
                end
            end
            
            plt=plot(x,y,style);
        end
        
    end
    
end


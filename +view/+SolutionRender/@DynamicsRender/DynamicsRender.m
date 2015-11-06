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
        
        function plt=fft(obj, name, varargin)
            style='ro-'; f=@(x) x; isRemoveAverage=1;
            for k=1:length(varargin)
                switch class(varargin{k})
                    case 'function_handle'
                        f=varargin{k};
%                        ylist=f(ylist);
                    case 'char'
                        style=varargin{k};
                    case 'struct'
                        para=varargin{k};
                        try
                            isRemoveAverage=para.rm_average;
                        catch
                            isRemoveAverage=0;
                        end
                end
            end
            
            res=obj.get_result();
            x=res('time');
            y=res(name);
            
            if isRemoveAverage
                y=y-mean(y);
            end
            
            dx_list=diff(x);
            dx=union(dx_list, dx_list);
            if length(dx) > 1
                warning('time list is not equidistant.')
                dx=dx(1);
            end
            df=1/dx;
            
            nfet=2^nextpow2(length(y));% Next power of 2 from length of y
            flist=df/2*linspace(0,1, nfet/2+1);
            ylist_all=fft(y, nfet)/length(y);
            ylist=ylist_all(1:nfet/2+1);

            ylist=f(ylist);
            plt=plot(flist,ylist,style);
        end
        
    end
    
end


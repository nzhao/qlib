function StoreKeyVariables(obj, varargin)
    for k=1:length(varargin)
        name_k=inputname(k+1);
        obj.keyVariables(name_k) = varargin{k};
    end
end
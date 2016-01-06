function GPU_Result = LoadFromGPU( obj, filename )
%LOADFROMGPU Summary of this function goes here
%   Detailed explanation goes here
    resfile=fopen(filename);
    dim=fread(resfile, 1, 'uint64');
    nt=fread(resfile, 1, 'uint64');
    dataR=fread(resfile, [dim, nt], 'double');
    dataI=fread(resfile, [dim, nt], 'double');
    fclose(resfile);
    
    fprintf('Data loaded: [dim =%d, nt =%d]\n', dim, nt);
    if nt~=length(obj.parameters.TimeList)
        warning('nt=%d does not equal to input timelist length=%d',nt, length(obj.parameters.TimeList));
    end
    
    GPU_Result=dataR+1i*dataI;
    obj.StoreKeyVariables(GPU_Result);
end


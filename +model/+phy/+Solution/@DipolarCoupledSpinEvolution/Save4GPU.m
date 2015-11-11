function Save4GPU(obj, filename, path )
%SAVE4GPU Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 2
        path=OUTPUT_FILE_PATH;
        filename='Data_';
    elseif nargin < 3
        path=OUTPUT_FILE_PATH;
    end
    
    obj.SetCondition();
    sc = obj.GetSpinList();
    st = obj.GetInitialState(sc);
    [hm, lv] = obj.GetHamiltonianLiouvillian(sc);
    
    full_name=[path, filename, obj.solutionName, '_', obj.timeTag, '.dat'];
    
    hm.export_interaction_data(full_name);
    st.export_vector(full_name);
    
    tlist=obj.parameters.TimeList;
    fileID = fopen(full_name,'a');
    fwrite(fileID, length(tlist), 'uint64'); 
    fwrite(fileID, tlist,'double');
    fclose(fileID);

    obj.StoreKeyVariables(sc, hm, lv, st);
end


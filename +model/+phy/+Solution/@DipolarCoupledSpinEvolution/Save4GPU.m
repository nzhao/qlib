function Save4GPU(obj, filename, path )
%SAVE4GPU Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 3
        path=OUTPUT_FILE_PATH;
    end
    
    obj.SetCondition();
    sc = obj.GetSpinList();
    st = obj.GetInitialState(sc);
    [hm, lv] = obj.GetHamiltonianLiouvillian(sc);
    
    hm.export_interaction_data([path, obj.solutionName, '_mat.dat']);
    st.export_vector([path, obj.solutionName, '_vec.dat']);
    
    tlist=eval(obj.parameters.TimeList);
    fileID = fopen([path, obj.solutionName, '_time.dat'],'w');
    fwrite(fileID, length(tlist), 'int'); 
    fwrite(fileID, tlist,'double');
    fclose(fileID);

    obj.StoreKeyVariables(sc, hm, lv, st);
end


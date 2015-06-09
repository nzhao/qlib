function export2GPU_Engine(obj, filename)
    hami=obj.keyVariables('hamiltonian');
    liou=hami.circleC();
    liouMat=liou.getMatrix();

    state=obj.keyVariables('densityMatrix');
    stateVect=full(state.getVector());

    timeList=obj.parameters.TimeList;
    nt=length(timeList);

    [dim,~]=size(liouMat);
    nonzero=nnz(liouMat);
    [iaT, jaT, a]=find(liouMat.');
    ia=jaT;
    ja=iaT;

    fileID = fopen(filename,'w');
    fwrite(fileID, dim,'int');
    fwrite(fileID, nonzero,'int');
    fwrite(fileID, nt,'int');

    fwrite(fileID, ia, 'int');
    fwrite(fileID, ja, 'int');
    fwrite(fileID, real(a), 'double');
    fwrite(fileID, imag(a), 'double');
    fwrite(fileID, real(stateVect), 'double');
    fwrite(fileID, imag(stateVect), 'double');
    fwrite(fileID, timeList, 'double');
    fclose(fileID);

end
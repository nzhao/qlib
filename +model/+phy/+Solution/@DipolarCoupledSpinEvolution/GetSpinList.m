function spin_collection=GetSpinList(obj)
    import model.phy.SpinCollection.SpinCollection
    import model.phy.SpinCollection.Strategy.FromFile
    para=obj.parameters;

    switch para.SpinCollectionStrategy
       case 'File'
           spin_collection=SpinCollection( FromFile(...
               [INPUT_FILE_PATH, para.InputFile]));
       case 'SpinList'
           error('not surported so far.');
    end
    spin_collection.set_spin();
end
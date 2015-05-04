clc;

%% FromFile
spin_collection1=model.phy.SpinCollection.SpinCollection();

xyzfile='/Users/nzhao/code/lib/active/qlib/+controller/+input/+xyz/RoyCoord.xyz';
strategy1=model.phy.SpinCollection.Strategy.FromFile(xyzfile);

spin_collection1.strategy=strategy1;
spin_collection1.generate();

%% FromSpinList 
spin_collection2=model.phy.SpinCollection.SpinCollection();

slist=[model.phy.Spin('13C', [1,1,1]), model.phy.Spin('13C', [10,10,10])];
strategy2 = model.phy.SpinCollection.Strategy.FromSpinList(slist);

spin_collection2.strategy=strategy2;
spin_collection2.generate();


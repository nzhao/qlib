%% Spin Chain: Prepare Data for GPU
% Need input file 'SpinChain.xml' in the folder specified by INPUT_FILE_PATH
% Output file 'Data_SpinChain.dat' with date and time tag
% in the folder specified by OUTPUT_FILE_PATH
clear;
sol=model.phy.Solution.SpinChain('SpinChain20Spin.xml');
sol.Save4GPU();

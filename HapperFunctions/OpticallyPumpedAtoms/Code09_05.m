% Code01_07  %atomic properties
% Code09_04  %cycling transition matrices
mug=kron(ones(gg,1),(fg:-1:-fg)');%left spin indices of ground-state tile
nug=kron((fg:-1:-fg)',ones(gg,1));%right spin indices of ground-state tile
lpg=mug==nug;%logical variable for ground-state populations
mue=kron(ones(ge,1),(fe:-1:-fe)');%left spin indices of excited-state tile
nue=kron((fe:-1:-fe)',ones(ge,1));%right spin indices of excited-state tile
np=2*ns+1;%number of tiles along diagonal of pq space
p=[]; q=[];%initialize tile indices
maxpmq=2*floor(fg);%maximum |p-q| for MOT
for km=1:maxpmq+1
    lpmq(:,km)=mug-nug==maxpmq+2-2*km;%log. var. of allowed coherences
    for kp=1:np %generate list of momentum indices
        p=[p;ns+maxpmq/2+2-km-kp];%left momentum index
        q=[q;ns-maxpmq/2+km-kp];%right momentum index
    end
end
gpq=length(p);%number of pq tiles

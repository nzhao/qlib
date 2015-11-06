function path = INPUT_FILE_PATH(  )
%INPUT_FILE_PATH Summary of this function goes here
%   Detailed explanation goes here
    if ismac || isunix
        path=[QLIB_PATH, '+controller/+input/'];
    else
         path=[QLIB_PATH, '+controller\+input\'];
    end
    
end


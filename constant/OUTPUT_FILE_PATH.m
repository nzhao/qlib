function path = OUTPUT_FILE_PATH(  )
%INPUT_FILE_PATH Summary of this function goes here
%   Detailed explanation goes here
if ismac
    path=[QLIB_PATH, '+controller/+output/'];
else
    path=[QLIB_PATH, '+controller\+output\'];
end
end


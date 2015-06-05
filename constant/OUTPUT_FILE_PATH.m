function path = OUTPUT_FILE_PATH(  )
%INPUT_FILE_PATH Summary of this function goes here
%   Detailed explanation goes here
if ismac
    path='/Users/nzhao/code/lib/active/qlib/+controller/+output/';
else
    path='C:\Users\Nan\Documents\GitHub\qlib\+controller\+output\';
end
end


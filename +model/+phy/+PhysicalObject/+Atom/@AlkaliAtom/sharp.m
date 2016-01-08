function M=sharp(S)
s=size(S);M=kron(S',eye(s(1)));
end
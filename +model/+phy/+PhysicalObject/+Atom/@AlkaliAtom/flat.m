function M=flat(S)
s=size(S);M=kron(eye(s(1)),S);
end
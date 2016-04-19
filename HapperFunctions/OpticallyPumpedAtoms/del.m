function y=del(a,b,c) 
y=sqrt(prod(1:a+b-c)*prod(1:a-b+c)*prod(1:-a+b+c)/prod(1:a+b+c+1)); 

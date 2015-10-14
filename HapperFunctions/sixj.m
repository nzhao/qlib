function y=sixj(a,b,c,d,e,f) 
y=del(a,b,c)*del(c,d,e)*del(a,e,f)*del(b,d,f); 
n1=max([-1 a+b+c c+d+e a+e+f b+d+f]); %greatest lower bound of n 
n2=min([a+b+d+e a+c+d+f b+c+e+f]);%least upper bound of n 
z=0; 
for n=n1:n2; 
z=z+(-1)^n *prod(1:n+1)/(prod(1:n-a-b-c)*prod(1:n-c-d-e)*... 
prod(1:n-a-e-f)*prod(1:n-b-d-f)*prod(1:a+b+d+e-n)*... 
prod(1:a+c+d+f-n)*prod(1:b+c+e+f-n)); 
end 
y=y*z; 
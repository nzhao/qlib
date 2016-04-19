function f=cg(a,al,b,be,c,ga) 
if al+be-ga ~= 0|c<abs(a-b)|c>a+b 
f=0; 
else 
w=prod(1:a+al)*prod(1:a-al)*prod(1:b+be)*prod(1:b-be)*... 
prod(1:c+ga)*prod(1:c-ga)*(2*c+1); 
w=sqrt(w); 
z1=max([0 b-c-al a+be-c]); % greatest lower bound of z 
z2=min([a+b-c a-al b+be]); % least upper bound of z 
f=0; 
for z=z1:z2; 
f=f+(-1)^z/(prod(1:z)*prod(1:a+b-c-z)*prod(1:a-al-z)*... 
prod(1:b+be-z)*prod(1:c-b+al+z)*prod(1:c-a-be+z)); 
end 
f=del(a,b,c)*w*f; 
end 

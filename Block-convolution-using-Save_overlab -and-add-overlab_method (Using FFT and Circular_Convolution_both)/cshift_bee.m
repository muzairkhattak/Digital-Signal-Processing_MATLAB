
function y = cshift_bee(x,r,N) 
x1=x;
if(N>length(x))
    
    x1 = [x, zeros(1, N-length(x))]; 
    
end

if (r<=0)

 y = [x1((length(x1)+r+1):length(x1)), x1(1:(length(x1)+r))];

else 

 y = [x1(r+1:length(x1)), x1(1:r)];
 
 

end
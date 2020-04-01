
function y = cflip_bee(x,N)

%where x = input array

% N = the number of points for circular flipping (DFT points)
x1=x;
%y = output that should be Modulo N circularly flipped version of x
if(N>length(x))
    
    x1 = [x, zeros(1, N-length(x))]; 
    
end



y = [x1(1), x1(length(x1):-1:2)];


%end
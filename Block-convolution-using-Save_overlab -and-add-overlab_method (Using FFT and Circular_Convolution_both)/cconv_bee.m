function y = cconv_bee(x,h,N)

%where x, h = input arrays

% N = the number of DFT points

%y = N point output of circular convolution

if(N>length(x))

 x = [x, zeros(1, N-length(x))];

end

if(N>length(h))

 h = [h, zeros(1, N-length(h))];
 %h will remain intact and make matrix of impulse h
end
flippled_h=cflip_bee(h,N);
flipped_matrix=zeros(N,N);
 for i=0:N-1
    
     temp_vector=cshift_bee(flippled_h,-i,N);
    
     flipped_matrix(i+1,:)=temp_vector;
 end
    
 %now time for matrix multiplication
 
y=(transpose(flipped_matrix*transpose(x)));

 

 % cconv_bee([1,1,1,1,1,1],[1,1,1,1,1,1],11]
end
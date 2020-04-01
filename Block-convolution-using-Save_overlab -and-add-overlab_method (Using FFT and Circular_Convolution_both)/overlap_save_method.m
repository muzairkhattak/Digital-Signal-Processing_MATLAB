function y = add_method_overlap_convolve(x,h,L)
%remember this method works when L>length(h) 

%step one , getting required chunks , but this time we will use while loop
%and break by force 

breaking_loop=1;
my_chunks_array=[];
tracking_index=1;

%padd zeros to input signal of size p-1
    
x=[zeros(1,length(h)-1),x];
while(breaking_loop==1)
    
    if(length(x(tracking_index:length(x)))<L)
        
        
        x=[x,zeros(1,L-length(x(tracking_index:length(x))))];
        my_chunks_array=[my_chunks_array;x(tracking_index:tracking_index+L-1)];
        tracking_index= (tracking_index+L-1)  - length(h)+1;
        
        breaking_loop=0;
        
        
    else
        
    
        my_chunks_array=[my_chunks_array;x(tracking_index:tracking_index+L-1)];
        tracking_index=tracking_index+1;
        tracking_index= (tracking_index+L-1)  - length(h)+1;
        tracking_index;
  
    end
    if(tracking_index+L-1==length(x))
            my_chunks_array=[my_chunks_array;x(tracking_index:tracking_index+L-1)];
            breaking_loop=0;
       
    end

end
%now to find convolution for each chunk of input signal but L point 
z=size(my_chunks_array);
z=z(1);

convolved_chunk_matrix=[];
for i=1:z
    
    single_chunk_convolved=linear_conv_using_fft(my_chunks_array(i,:),h,L);
    
    convolved_chunk_matrix=[convolved_chunk_matrix;single_chunk_convolved];
    
end

%now discarding the first p-1 points of each convolved_input_chunk vector

discarded_p_minus_1_matrix=[];
for i=1:z
    discarded_p_minus_1_matrix=[discarded_p_minus_1_matrix;convolved_chunk_matrix(i,length(h):L)];
end
%now concatinating into single vector 
final_ans=[];
for i=1:z
   final_ans=[final_ans,discarded_p_minus_1_matrix(i,:)];
end
final_ans
end
function y = add_method_conv(x,h,L)

%x input signal
%h filter signal (impulse response)
%L chunks size of x divisions into smaller inpu signals


%step one --> finding individual outputs of chunks of x[n]

remainder=mod(x,L);
if remainder==0
    total_chunks=length(x)/L;
    last_fraction=0;
else
    total_chunks=floor(length(x)/L)+1;
    last_fraction=1;
end
total_chunks;
my_chunks_array=zeros(total_chunks,L);
for  i=0:total_chunks-1 
    
    if(i==total_chunks-1 && last_fraction==1)
        %means last chunk needs padding
        
        temp_single_chunk=[x(i*L+1:length(x)),zeros(1,L-length(x(i*L+1:length(x))))];
        my_chunks_array(i+1,:)=temp_single_chunk;
    else
        
        temp_single_chunk=x(i*L+1:i*L+L);
        my_chunks_array(i+1,:)=temp_single_chunk;
         
    end
    
end

%now next step , we will convolving each chunk with the filter's response
chunks_convolved_matrix=zeros(total_chunks,L+length(h)-1);

for i=1:total_chunks
    
    single_chunk_convolved=linear_conv_using_fft(my_chunks_array(i,:),h,L+length(h)-1);
    
    chunks_convolved_matrix(i,:)=single_chunk_convolved;
    
end

chunks_convolved_matrix;
%now last step, adding all the outputs together
final_ans=[];
for i=1:total_chunks
    if i==1
        final_ans=chunks_convolved_matrix(i,:);
    
    else
       
        temp=chunks_convolved_matrix(i,:);
        
        temp_common_points_addition=final_ans(length(final_ans)-length(h)+2:length(final_ans))+temp(1:length(h)-1);
        
        final_ans=[final_ans(1:length(final_ans)-length(h)+1),temp_common_points_addition,temp(length(h):length(temp))];
        
    end
end
final_ans
end
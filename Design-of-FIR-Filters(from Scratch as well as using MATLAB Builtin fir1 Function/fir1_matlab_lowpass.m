function []=fir1_matlab_lowpass(stopband_edge,passband_edge,sampling_frq)

%making fir filters using builtin matlab function
%window to be used : Hamming
%sampling frequency 10Khz


%Finding paramaters which have to be passed to fir1()


transition_width=((stopband_edge-passband_edge)*2*pi)/sampling_frq
%Filter Order 
M = ceil(6.6*pi/transition_width)
if rem( M , 2 )==0
    M = M+1
end

%normalized cuttoff freq
normalized_cuttoff=passband_edge/(sampling_frq/2)

b=fir1(M,normalized_cuttoff)

[H,w] = freqz(b,1,1000,'whole') ;
%fir1_matlab_lowpass(4300,1000,10000)

plot(w,abs(H))
xlabel('Low Pass filter , Frequency response')
ylabel('H(ejw)')
end
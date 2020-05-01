function []=fir1_matlab_lowpass(stopband_edge,passband_edge,sampling_frq)

%making fir filters using builtin matlab function
%window to be used : Hamming
%sampling frequency 10Khz


%Finding paramaters which have to be passed to fir1()


transition_width=((stopband_edge-passband_edge))
%Filter Order 
M = ceil(6.1*pi/transition_width)
if rem( M , 2 )==0
    M = M+1
end

%normalized cuttoff freq
normalized_cuttoff=((passband_edge + transition_width/2))/((sampling_frq/2))
window=bartlett(M+1)
b=fir1(M,normalized_cuttoff,window)

[H,w] = freqz(b,1,1000) ;
%fir1_matlab_lowpass(38,32,200)

plot(w,abs(H))
title('Corresponding FIR filter')
xlabel('Low Pass filter , Frequency response')
ylabel('H(ejw)')
end

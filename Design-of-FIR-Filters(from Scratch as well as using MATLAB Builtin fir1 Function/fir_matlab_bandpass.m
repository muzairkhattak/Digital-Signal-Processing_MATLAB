function []=fir_matlab_bandpass(lower_stopband_edge,lower_passband_edge,upper_passband_edge,upper_stopband_edge,sampling_frq)

%making fir filters using builtin matlab function
%window to be used : Hamming
%sampling frequency 10Khz


%Finding paramaters which have to be passed to fir1()
transition_width=(min((lower_passband_edge-lower_stopband_edge),(upper_stopband_edge-upper_passband_edge))*2*pi)/sampling_frq;


%Filter Order 
M = ceil(6.6*pi/transition_width)
if rem( M , 2 )==0
    M = M+1
end

%normalized cuttoff freq

wc1=(lower_passband_edge+lower_stopband_edge)/2;

normalized_cuttoff_wc1=lower_passband_edge/(sampling_frq/2)

wc2=(upper_passband_edge+upper_stopband_edge)/2;

normalized_cuttoff_wc2=(upper_passband_edge)/(sampling_frq/2)

%b=fir1(M,[normalized_cuttoff_wc1,normalized_cuttoff_wc2])
b=fir1(M,[normalized_cuttoff_wc1,normalized_cuttoff_wc2])
%,normalized_cuttoff_wc2
[H,w] = freqz(b,1,1000,'whole') ;
%fir_matlab_bandpass(7000,8000,16000,17000,48000)

plot(w,abs(H))
xlabel('BAND Pass filter , Frequency response')
ylabel('H(ejw)')
end

%Digital Signal Processing 
%Lab Task 1
%Making a bandpass fir filter , from scratch

function []=fir_bandpass_filter(lower_stopband_edge,lower_passband_edge,upper_passband_edge,upper_stopband_edge)

%step 1:Finding transition Width
transition_width=min((lower_passband_edge-lower_stopband_edge),(upper_stopband_edge-upper_passband_edge));

%for this particular example ,we required stop band attenuation of 60dB ,
%so we will use Blackman Window

%step 3
%Calculating Cutt-off frequencies 

wc1=(lower_passband_edge+lower_stopband_edge)/2;
wc2=(upper_passband_edge+upper_stopband_edge)/2;

M = ceil(11*pi/transition_width)
if rem( M , 2 )==0
    M = M+1
end
%step 4 : creating ideal bandpass filters using two low pass filters
hd1 =ideal_lp(wc1,M);
hd2 =ideal_lp(wc2,M);
% Ideal band pass ?using above ideal low-pass filters
hd=hd2-hd1;
%using blackman window 
given_window= blackman(M);
size(hd)
size(transpose(given_window))
size(hd.*transpose(given_window))
h=[]
h = hd.*transpose(given_window);
%now plotting the results
%ideal impulse response
subplot(2,2,1)

stem([0:1:length(hd)-1],hd);
xlabel('Ideal Impulse Response')
ylabel('hd[n]')
subplot(2,2,2)
stem([0:1:length(h)-1],h);
xlabel('Truncated Impulse Response')
ylabel('h[n]')
size(h)

%now plotting the impulse responses and windows

subplot(2,2,3)
stem([0:1:length(given_window)-1],given_window);
xlabel('Choosen Window ')
ylabel('w[n]')


subplot(2,2,4)
[db,mag,pha,grd,w]=freqz_m(h,1)
plot(w,db)
xlabel('Frequency Response in dBs ')
ylabel('H(ejw)')

%fir_bandpass_filter(0.2*pi,0.35*pi,0.65*pi,0.8*pi)
end

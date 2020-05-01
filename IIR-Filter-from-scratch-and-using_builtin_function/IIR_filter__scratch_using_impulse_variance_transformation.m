%Designing a IIR digital filter using analogue filter and then impulse
%invariance technique

%given specifications
%butterworth filter with N=4, wc=0.3pi and Td=2
wc=0.3*pi
N=4
Td=2
%step 1 : Convert specifications into analogue domain values

Ohm_C= wc/Td;

%step 2 : find butterworth filter cofficients
%running a loop across N to find all analogue filter cofficients
my_filter_cofficients=[]
for k=0:N-1

current_cofficient=Ohm_C*exp(j*(pi/(2*N))*(2*k+N+1))   
my_filter_cofficients=[my_filter_cofficients, current_cofficient]
end

%now making butterworth filter

[num,deno]=zp2tf([],my_filter_cofficients,Ohm_C.^N)
%filter in s- domain
my_filter_s_domain= tf(num,deno)
subplot(2,2,1)
%plotting the time-domain transfer function
impulse(my_filter_s_domain)
title('Impulse response in Time Domain')
subplot(2,2,2)
%plotting the magnitude |H(jOhm)|
[h_s,wout] = freqs(num,deno,500);
plot(wout,abs(h_s))
title('|H(jOhm)|  Analogue Filter Transfer Function')
xlabel('Ohm Axis')
%----------------------------------------------------
%last step , using impulse invariance method to convert into digital domain
sampling_freq=1
[digital_num,digital_deno] = impinvar(num,deno,sampling_freq) 

%plotting the converted discrete time impulse response
subplot(2,2,3)
discrete_system=tf(digital_num,digital_deno,-1)
[y,n] = impulse(discrete_system);
stem(n,y)
xlabel('n')
ylabel('h[n]')
title('Impulse response in Discrete time domain')
%plotting magnitude of transfer function
subplot(2,2,4)
[h,w] = freqz(digital_num,digital_deno,100);

plot(w,abs(h));
title('Frequency response of converted digital filter')
xlabel('w axis')
ylabel( '|H(ejw)|')
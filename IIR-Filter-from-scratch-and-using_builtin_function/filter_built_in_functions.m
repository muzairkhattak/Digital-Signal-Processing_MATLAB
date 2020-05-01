% we are given certain specifications for low pass filter design 
%we will find the Order and acheived cuttoff frequency for each analogue
%filter
%we are given passband edge and stop band edge frequencies
sampling_freq=200     %in hertz;
Wp=32;
Ws=38;
Rp=1;
Rs=25;
normalized_passband=Wp/(sampling_freq/2);
normalized_stopband=Ws/(sampling_freq/2);
%finding order for butterworth filter design
[n_butter,Wn_butter] = buttord(normalized_passband,normalized_stopband,Rp,Rs);
%finding order for butterworth filter design
[n_cheb,Wn_cheb] = cheb1ord(normalized_passband,normalized_stopband,Rp,Rs);
%finding order for butterworth filter design
[n_ellip,Wn_ellip] = ellipord(normalized_passband,normalized_stopband,Rp,Rs);

disp('Order for the Butterworth filter is given as ')
disp(n_butter)
disp('Order for the Chebeshve filter is given as ') 
disp(n_cheb)
disp('Order for the ellip filter is given as ' )
disp( n_ellip)
%---------------------------------------------------------------------
%Now after finding the specifications ,lets make filters using built-in
%function

%Butterworth
[num,deno] =ellip(n_ellip,Rp,Rs,normalized_passband)
[h1,w1] = freqz(num,deno,1000)
subplot(3,1,1)
plot(w1,abs(h1))
title('Elliptic Filter')
xlabel('w axis')
ylabel('|H(e(jw))|')
my_transfer_function=tf(num,deno,-1)
subplot(3,1,2)
pzmap(my_transfer_function)
title('zero pole map of Elliptic filter Transfer function')
[y,n] = impulse(discrete_system);
subplot(3,1,3)
stem(n,y)
xlabel('n')
ylabel('h[n]')
title('Impulse response in Discrete time domain')



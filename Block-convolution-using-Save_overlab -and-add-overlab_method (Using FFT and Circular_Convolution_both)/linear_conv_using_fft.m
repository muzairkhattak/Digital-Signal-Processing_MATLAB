function y = linear_conv_using_fft(x,h,N)

if(N>length(x))

 x = [x, zeros(1, N-length(x))];

end

if(N>length(h))

 h = [h, zeros(1, N-length(h))];

end

x_FFT=fft(x);
h_FFT=fft(h);


dot_product=x_FFT.*h_FFT;

y=ifft(dot_product);

end

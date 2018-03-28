%Lab4 EE341
%Group members: Graham Arnold, Ting-Yu(Jacky) Wang
%Group member contribution: Each group member contributed equally to this
%script, the script was written collaboratively with both members working
%on the same task.

%% Part 1
f1 = 0.25;
f2 = 0.5;
n = 0:127;
N = 128;

x1 = 1 + cos(2*pi*f1*n);
x2 = 1 + cos(2*pi*f2*n);

% f = 0.25
y1 = fft(x1, N);
y2 = fftshift(y1);

figure;
subplot(2, 1, 1);
stem((0:127)/N, abs(y1));
title('FFT f = 0.25');
xlabel('Normalized Frequency');
ylabel('Magnitude');

subplot(2, 1, 2);
stem((-N/2:(N/2)-1)/N, abs(y2));
title('Shifted FFT f = 0.25');
xlabel('Normalized Frequency');
ylabel('Magnitude');

% f = 0.5
y3 = fft(x2, N);
y4 = fftshift(y3);

figure;
subplot(2, 1, 1);
stem((0:127)/N, abs(y3));
title('FFT f = 0.5');
xlabel('Normalized Frequency');
ylabel('Magnitude');

subplot(2, 1, 2);
stem((-N/2:(N/2)-1)/N, abs(y4));
title('Shifted FFT f = 0.5');
xlabel('Normalized Frequency');
ylabel('Magnitude');

% f = 0.26
f3 = 0.26;
x3 = 1 + cos(2*pi*f3*n);

N = 32;
y5 = fft(x3, N);
y6 = fftshift(y5);

figure
subplot(3, 1, 1);
stem((-N/2:(N/2)-1)/N, abs(y6));
title('Shifted FFT f = 0.26 N = 32');
xlabel('Normalized Frequency');
ylabel('Magnitude');

N = 128;
y7 = fft(x3, N);
y8 = fftshift(y7);

subplot(3, 1, 2);
stem((-N/2:(N/2)-1)/N, abs(y8));
title('Shifted FFT f = 0.26 N = 128');
xlabel('Normalized Frequency');
ylabel('Magnitude');

N = 512;
y9 = fft(x3, N);
y10 = fftshift(y9);

subplot(3, 1, 3);
stem((-N/2:(N/2)-1)/N, abs(y10));
title('Shifted FFT f = 0.26 N = 512');
xlabel('Normalized Frequency');
ylabel('Magnitude');

%% flute
[y, Fs] = audioread('flute-short.wav');

z1 = fft(y);
z2 = fftshift(z1);

plot(linspace(-0.5, 0.5, length(z2))*Fs, log(abs(z2)));
title('Shifted FFT of flute-short');
xlabel('Frequency');
ylabel('Magnitude');


%% Part 2

f1 = 0.15;
f2 = 0.2;
f3 = 0.4;
n = 0:255;
N = 256;

x1 = sinc(f1*(n-32));
x2 = sinc(f1*(n-32)).*(-1).^n;
x3 = sinc(f1*(n-32)).*cos(2*pi*f2*n);
x4 = sinc(f3*(n-32)).*cos(2*pi*f3*n);


y1 = fftshift(fft(x1));
y2 = fftshift(fft(x2));
y3 = fftshift(fft(x3));
y4 = fftshift(fft(x4));


% Part a
figure;
subplot(2, 1, 1);
plot((-N/2:(N/2)-1)/N, abs(y1));
title('Shifted FFT Part a');
xlabel('Normalized Frequency');
ylabel('Magnitude');

subplot(2, 1, 2);
plot((-N/2:(N/2)-1)/N, angle(y1));
title('Shifted FFT Part a');
xlabel('Normalized Frequency');
ylabel('Phase');

% Part b
figure;
subplot(2, 1, 1);
plot((-N/2:(N/2)-1)/N, abs(y2));
title('Shifted FFT Part b');
xlabel('Normalized Frequency');
ylabel('Magnitude');

subplot(2, 1, 2);
plot((-N/2:(N/2)-1)/N, angle(y2));
title('Shifted FFT Part b');
xlabel('Normalized Frequency');
ylabel('Phase');

% Part c
figure;
subplot(2, 1, 1);
plot((-N/2:(N/2)-1)/N, abs(y3));
title('Shifted FFT Part c');
xlabel('Normalized Frequency');
ylabel('Magnitude');

subplot(2, 1, 2);
plot((-N/2:(N/2)-1)/N, angle(y3));
title('Shifted FFT Part c');
xlabel('Normalized Frequency');
ylabel('Phase');

% Part d
figure;
subplot(2, 1, 1);
plot((-N/2:(N/2)-1)/N, abs(y4));
title('Shifted FFT Part d');
xlabel('Normalized Frequency');
ylabel('Magnitude');

subplot(2, 1, 2);
plot((-N/2:(N/2)-1)/N, angle(y4));
title('Shifted FFT Part d');
xlabel('Normalized Frequency');
ylabel('Phase');



%% Part 3
close all;

load('norm_stock.txt');

stock = norm_stock(1:512);

% low pass filter from lab 3
[b_fir1, a_fir1] = fir1(10, 0.3, 'low');
yfir1 = filter(b_fir1, a_fir1, stock);

y1 = fft(yfir1);
z1 = fftshift(y1);
N = 512;

figure;
subplot(3, 1, 1);
plot((-N/2:(N/2)-1)/N, log(abs(z1)));
title('LPF DFT Stock Data');
xlabel('Frequency');
ylabel('Magnitude');

% high pass filter from lab 3
[b_fir2, a_fir2] = fir1(10, 0.3, 'high');

yfir2 = filter(b_fir2, a_fir2, stock);
yfir2 = conv(stock, b_fir2, 'same');

y2 = fft(yfir2);
z2 = fftshift(y2);
N = 512;

subplot(3, 1, 2);
plot((-N/2:(N/2)-1)/N, log(abs(z2)));
title('HPF DFT Stock Data');
xlabel('Frequency');
ylabel('Magnitude');

% original signal
y3 = fft(stock);
 z3 = fftshift(y3);

subplot(3, 1, 3);
plot((-N/2:(N/2)-1)/N, log(abs(z3)));
title('Original DFT Stock Data');
xlabel('Frequency');
ylabel('Magnitude');

z3(102:410) = 0;
figure
plot((-N/2:(N/2)-1)/N, z3);
title('Frequency zeroed DFT of stock signal');
xlabel('Frequency');
ylabel('Magnitude');

hpf_signal = ifft(z3);
xlim([-0.5, 0.5]);

figure
%subplot(2, 1, 1);
plot(yfir2); hold on;
%subplot(2, 1, 2);
plot(real(hpf_signal), 'r'); ylim([-1, 1]);
title('High-pass filter comparison');
xlabel('Time(n)');
ylabel('Magnitude');

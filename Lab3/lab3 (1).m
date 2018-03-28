%Lab3 EE341
%Group members: Graham Arnold, Ting-Yu(Jacky) Wang
%Group member contribution: Each group member contributed equally to this
%script, the script was written collaboratively with both members working
%on the same task.

%% Part 1

load microsoftstock.txt;

a = 1;
b(1:30) = 1/30;

% 30 days moving average
h = filter(b,a,[1 zeros(1,29)]);

yfilter = filter(b, a, microsoftstock);
yconv = conv(microsoftstock, h);

figure
clear title xlabel ylabel
plot(microsoftstock(30:end));
hold on
plot(yfilter(30:end), 'r'); 
hold on
plot(yconv(30:end));
xlabel('Days');
ylabel('Stock Value');
title('Microsoft Stock');

% Extracting high frequencies
a2 = 1;
b2 = [1 -1];

hsimple = filter(b2, a2, [1 zeros(1, 1)]);
y3 = conv(microsoftstock, hsimple);

hold on
plot(y3(30:end));

% frequency response plot
figure
freqz(b, a);
figure
freqz(b2, a2);

xlabel('Freqency');
ylabel('Magnitude');
title('Microsoft Stock Frequency Response');

%% Part 2

[b_fir, a_fir] = fir1(10, 0.3);

[b_but, a_but] = butter(10, 0.3);

% figure
% freqz(b_fir, a_fir);
% figure
% freqz(b_but, a_but);
% 
% figure
% impz(b_fir, a_fir);
% figure
% impz(b_but, a_but);

% stock market
yfir1 = filter(b_fir, a_fir, microsoftstock);
ybut1 = filter(b_but, a_but, microsoftstock);

% plot(microsoftstock)
% hold on
% plot(ybut1);
% hold on
% plot(yfir1);
% legend Original Butterworth FIR

% a pulse length of twenty
x(1:20) = 1;
pulse = [x zeros(1, 40)];

yfir2 = filter(b_fir, a_fir, pulse);
ybut2 = filter(b_but, a_but, pulse);

plot(pulse)
hold on
plot(ybut2);
hold on
plot(yfir2);
legend Original Butterworth FIR

% music
[y,Fs] = audioread('music.wav');

yfir3 = filter(b_fir, a_fir, y);
ybut3 = filter(b_but, a_but, y);

% sound(y, Fs);
% sound(yfir3, Fs);
% sound(ybut3, Fs);

%% Part 3

% music equalizer filters

[b1, a1] = fir1(4, 1/5, 'low');
[b2, a2] = fir1(4, [1/5 2/5], 'band');
[b3, a3] = fir1(4, [2/5 2/3], 'band');
[b4, a4] = fir1(4, 2/3, 'high');

% freqz(b1, a1);
% hold on
% freqz(b2, a2);
% hold on
% freqz(b3, a3);
% hold on
% freqz(b4, a4);


% music
[y,Fs] = audioread('music.wav');

equalized = equalize(1, 1, 1, 1, a1, a2, a3, a4, b1, b2, b3, b4, y);

% sound(y, Fs);
% sound(equalized, Fs);

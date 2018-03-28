%Lab1 EE341
%Group members: Graham Arnold, Ting-Yu(Jacky) Wang
%Group member contribution: Each group member contributed equally to this
%script, the script was written collaboratively with both members working
%on the same task. For part 4 each member modified their own sound to be
%turned in.

%% Part 1

fs = 8000;

% Note frequencies
fa = 220;
fb = 220 * 2^(2 / 12);
fc = 220 * 2^(3 / 12);
fe = 220 * 2^(7 / 12);

wa = fa * 2 * pi;
wb = fb * 2 * pi;
wc = fc * 2 * pi;
we = fe * 2 * pi;

% Note counts in second
T1 = 0.5;
t1 = 0:(1 / fs):T1;

T2 = 1;
t2 = 0:(1 / fs):T2;

T4 = 2;
t4 = 0:(1 / fs):T4;

% Pause between notes
pause = zeros(1, 0.05 * fs);

% Notes
A1 = sin(wa * t1);
A2 = sin(wa * t2);
A4 = sin(wa * t4);

B1 = sin(wb * t1);

C1 = sin(wc * t1);

E1 = sin(we * t1);

% Final music
musique = [A2, pause, A1, pause, E1, pause, E1, pause, E1, pause, B1, pause, C1, pause, B1, pause, A4];

%soundsc(musique, fs);


%% Part 2

% Note type
whole = 4;
half = 2;
fourth = 1;

% Amplitude scaled notes
A_1 = A1 .* ampScale(T1, fs, fourth);
A_2 = A2 .* ampScale(T2, fs, half);
A_4 = A4 .* ampScale(T4, fs, whole);

B_1 = B1 .* ampScale(T1, fs, fourth);

C_1 = C1 .* ampScale(T1, fs, fourth);

E_1 = E1 .* ampScale(T1, fs, fourth);

% Final modified music 
musique_mod = [A_2, pause, A_1, pause, E_1, pause, E_1, pause, E_1, pause, B_1, pause, C_1, pause, B_1, pause, A_4];

%soundsc(musique_mod, fs);

audiowrite('part2.wav', musique_mod, fs);

% % Volume Window Plot
% figure;
% plot(ampScale(0.5, fs, fourth));
% hold on
% plot(ampScale(1, fs, half));
% hold on
% plot(ampScale(2, fs, whole));
% xlabel('t')
% ylabel('Volume')
% title('Volume Window ADSR')
% legend('Fourth Note', 'Half Note', 'Whole Note')


%% Part 3

f = 100;
w = 2*pi*f;
fs = 5000;

% time vector
t = 0:1/fs:5;

cosig = cos(w*t);

% noise var
noise = randn(1, length(t));
decay = linspace(5, 0, length(t));

ocean = cosig .* noise .* decay;

%soundsc(ocean, fs);

audiowrite('part3.wav', ocean, fs);

%% Part 4

[ycat, fscat] = audioread('cat.wav');
[ytig, fstig] = audioread('tiger.wav');

%soundsc(ytig, 4*fstig);
%soundsc(ycat, fscat/4);


[yKennedy, fsKennedy] = audioread('kennedy2.wav');

soundsc(yKennedy, fsKennedy/2);

audiowrite('part4.wav', yKennedy, fsKennedy/2);
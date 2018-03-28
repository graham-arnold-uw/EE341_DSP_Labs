%Lab5 EE341
%Group members: Graham Arnold
%Project description: The take me out to the ball game song is synthesized
%and compiled, then each note is modified with the ADSR envelope and
%finally a soundbite is added to the end which has been slowed down using
%time scaling of the sampling frequency

%% Take me out to the ball game music

fs = floor(44100/1.3);

% Note frequencies
fg = 220*2^(10/12);
fe = 220*2^(7/12);
fd = 220*2^(5/12);
fd2 = 440*2^(5/12);
ff = 220*2^(8/12);
ffsharp = 220*2^(9/12);
fa = 440;
fc = 220*2^(3/12);
fc2 = 440*2^(3/12);
fb = 440*2^(2/12);
fgsharp = 220*2^(11/12);


wg = fg * 2 * pi;
we = fe * 2 * pi;
wd = fd * 2 * pi;
wf = ff * 2 * pi;
wd2 = fd2 * 2 * pi;
wfsharp = ffsharp * 2 * pi;
wf = ff * 2 * pi;
wa = fa * 2 * pi;
wc = fc * 2 * pi;
wc2 = fc2 * 2 * pi;
wb = fb * 2 * pi;
wgsharp = fgsharp * 2 * pi;

% Note counts in second
T3 = 1.5;
t3 = 0:(1 / fs):T3;

T1 = 0.5;
t1 = 0:(1 / fs):T1;

T2 = 1;
t2 = 0:(1 / fs):T2;

T6 = 3;
t6 = 0:(1 / fs):T6;

T4 = 2;
t4 = 0:(1 / fs):T4;

% Pause between notes
pause = zeros(1, floor(0.05 * fs));
pauseCount = zeros(1, length(t1));

% Notes
G = sin(wg * t1);
D = sin(wd * t1);
E = sin(we * t1);
C = sin(wc * t2);
Clow2 = sin(wc * t2);
C2 = sin(wc2* t2);
C21 = sin(wc2 * t1);
C3 = sin(wc2 * t3);
C6 = sin(wc2 * t6);
A = sin(wa * t1);
A2 = sin(wa * t2);
A3 = sin(wa * t3);
E2 = sin(we * t2);
D2 = sin(wd * t2);
D3 = sin(wd * t3);
G3 = sin(wg * t3);
G6 = sin(wg * t6);
Fsharp = sin(wfsharp * t1);
B = sin(wb * t1);
B3 = sin(wb * t3);
Gsharp = sin(wgsharp * t1);
F = sin(wf * t1);
Dhigh = sin(wd2 * t1);

 musique = [C, pause, C21, pause, A, pause, G, pause, E, pause, G3, pause, D3, pause, C, pause,... 
     C21,pause, A, pause, G, pause, E, pause G6, pauseCount, A, pause, Gsharp, pause, A, pause, E, ...
     pause, F,pause, G, pause, A2, pause, F, pause, D3, pause, A2, pause, A, pause, A, pause, B, pause,...
     C21, pause, Dhigh, pause,B, pause, A, pause, G, pause, E, pause D, pause, Clow2, pause, C21, pause,... 
     A, pause, G, pause, E, pause,G3, pause, D2, pause, D, pause, Clow2, pause, D, pause, E, pause, F, pause,...
     G, pause, A3, pause, A, pause, A, pause,B, pause, C3, pause, C3, pause, C21, pause, B, pause, A, pause,...
     G, pause, Fsharp, pause, G, pause,A3, pause, B3, pause, C6, pauseCount];

 %soundsc(musique, fs);
%% ADSR envelope modification

% Note type
whole = 4;
half = 2;
fourth = 1;
eighth = 0.5;
six = 6;
three = 3;

% Amplitude scaled notes
G = G .* ampScale(T1, fs, fourth);
D = D .* ampScale(T1, fs, fourth);
E = E .* ampScale(T1, fs, fourth);
C = C .* ampScale(T2, fs, half);
Clow2 = Clow2 .* ampScale(T2, fs, half);
C2 = C2 .* ampScale(T2, fs, half);
C21 = C21 .* ampScale(T1, fs, fourth);
C3 = C3 .* ampScale(T3, fs, three);
C6 = C6 .* ampScale(T6, fs, six);
A = A .* ampScale(T1, fs, fourth);
A2 = A2 .* ampScale(T2, fs, half);
A3 = A3 .* ampScale(T3, fs, three);
E2 = E2 .* ampScale(T2, fs, half);
D2 = D2 .* ampScale(T2, fs, half);
D3 = D3 .* ampScale(T3, fs, three);
G3 = G3 .* ampScale(T3, fs, three);
G6 = G6 .* ampScale(T6, fs, six);
Fsharp = Fsharp .* ampScale(T1, fs, fourth);
B = B .* ampScale(T1, fs, fourth);
B3 = B3 .* ampScale(T3, fs, three);
Gsharp = Gsharp .* ampScale(T1, fs, fourth);
F = F .* ampScale(T1, fs, fourth);
Dhigh = Dhigh .* ampScale(T1, fs, fourth);


musique = [C, pause, C21, pause, A, pause, G, pause, E, pause, G3, pause, D3, pause, C, pause,... 
     C21,pause, A, pause, G, pause, E, pause G6, pauseCount, A, pause, Gsharp, pause, A, pause, E, ...
     pause, F,pause, G, pause, A2, pause, F, pause, D3, pause, A2, pause, A, pause, A, pause, B, pause,...
     C21, pause, Dhigh, pause,B, pause, A, pause, G, pause, E, pause D, pause, Clow2, pause, C21, pause,... 
     A, pause, G, pause, E, pause,G3, pause, D2, pause, D, pause, Clow2, pause, D, pause, E, pause, F, pause,...
     G, pause, A3, pause, A, pause, A, pause,B, pause, C3, pause, C3, pause, C21, pause, B, pause, A, pause,...
     G, pause, Fsharp, pause, G, pause,A3, pause, B3, pause, C6, pauseCount];

 %soundsc(musique, fs);

%% Umpire "play ball" sound

[yball, fsball] = audioread('PlayBall.wav');

 %soundsc(yball, fs);

 yball = yball(:, 1);
 yball = yball';
 fsball = fsball/1.3;

%% Final compilation of song plus the sound

final = horzcat(1, musique, yball);

 soundsc(final, fs);

audiowrite('ballgame.wav', final, fs);
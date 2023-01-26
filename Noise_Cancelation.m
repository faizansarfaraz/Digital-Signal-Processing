%clear all previous commands
clear
clc
clf

%Read the original sound file
[combined, Fs1] = audioread('math_Combo.mp3'); %reads in sound file
[static, Fs2] = audioread('math_Static.mp3');

%Plots
t = @(Fs, file) [1/Fs:1/Fs:length(file)/Fs]; %sets the signal increments for plotting

%Take Laplace of combined and static signal
LapComb = fft(combined);
LapStat = fft(static);

%Subtract the fequencies out
LapClean = LapComb - LapStat;

%Take Inverse Transform
clean = ifft(LapClean);

%Plots
s = @(Fs) [1/Fs:Fs/length(combined)/2:Fs/2];

subplot (3,2,1)
plot(t(Fs1, combined), combined); %original signal
title('Original recoding (with noise)')
xlabel ('time (in seconds)')
ylabel ('amplitude')

subplot (3,2,2)
plot(t(Fs1, combined)-4.5, LapComb); %original in the frequency domain
axis([0 5 -100 100])
title('Original recoding (with noise)')
xlabel ('frequency')
ylabel ('amplitude')

subplot (3,2,4)
plot(t(Fs1/4, combined)-4.5, LapStat); %static in frequency domain
axis([0 5 -100 100])
title('Background noise recording')
xlabel ('frequency')
ylabel ('amplitude')

subplot (3,2,6)
plot(t(Fs1/4, combined)-4.5, LapClean); %clear signal in frequency domain
axis([0 5 -100 100])
title('Recording after noise removal')
xlabel ('frequency')
ylabel ('amplitude')

subplot (3,2,3)
plot(t(Fs1/4, combined)-4.5, clean); %final signal in time domain
title('Recording after noise removal')
xlabel ('time (in seconds)')
ylabel ('amplitude')

%Combine track of before and after, then play sound
mCompare = [combined; clean];
sound(mCompare, Fs1)
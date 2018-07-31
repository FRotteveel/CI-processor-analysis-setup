function [z] = double_freq(d, L, f1, f2, filename)
%creates a 2 frequency tone .wav file and array z with tone length d and
%relative loudness loud.
%INPUT:
%   d = tone length
%   L = loudness, value between 0 and 1
%   f = frequency
%   filename = string containing .wav

%OUTPUT:
%   z = an array of the waveform
%   .wav audiofile


fs = 44100;
n = round(d*fs);
t = (0:n-1)/fs;

%the cosgate function smooths out the edges of the waveforms, preventing
%clicks on the beginningand ending of tones.
z = cosgate((L*sin(2*pi*f1*t) + L*sin(2*pi*f2*t)), fs, 50e-3);
audiowrite(filename, z, fs);
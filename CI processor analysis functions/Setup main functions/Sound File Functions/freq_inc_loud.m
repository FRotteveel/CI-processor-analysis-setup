function [z] = freq_inc_loud(d, f, filename)
%creates a frequency tone .wav file and array z with tone length d with an increasing loudness from 0 to 1.
%INPUT:
%   d = tone length
%   f = frequency
%   filename = string containing .wav

%OUTPUT:
%   z = an array of the waveform
%   .wav audiofile


fs = 44100;
n = round(d*fs);
t = (0:n-1)/fs;


z = cosgate(((t/d).*sin(2*pi*f*t)), fs, 50e-3);
audiowrite(filename, z, fs);
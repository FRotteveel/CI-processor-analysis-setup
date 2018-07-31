function [z] = single_freq(d, L, f, filename)
%creates a frequency tone .wav file and array z with tone length d, 
%loudnness L and frequency f.
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

z = cosgate((L*sin(2*pi*f*t)), fs, 50e-3);;
audiowrite(filename, z, fs);
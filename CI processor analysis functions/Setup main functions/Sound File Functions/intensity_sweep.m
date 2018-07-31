function [x, fs, L] = intensity_sweep(d, f, filename)
%creates an intensity sweep .wav file and array x with tone length d and 
%frequency f.

%INPUT
%   d = length of each tone in seconds.
%   f = frequency of the tone.
%   filename = string which must end on .wav.

%OUTPUT
%   x = array of different loudness factors.
%   if filename given: .wav file of x.

fs = 44100;
n = round(d*fs);
t = (0:n-1)'/fs;

L = exp(linspace(log(.002), log(1), 30)); %increasing loudness with 
%   logarithmic steps.
x = [];

for i=1:length(L)
    x = [x; cosgate(L(i)*sin(2*pi*f*t), fs, 10e-3); zeros(round(50e-3*fs),1)];
end

x = .98*x/max(abs(x));

if nargin>2 %only saves the file if filename is given.
    audiowrite(filename, x, fs); 
end

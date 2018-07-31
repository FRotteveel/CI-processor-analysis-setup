function [x, fs, freqs] = freq_sweep(d,filename)
%creates a frequency sweep .wav file and array z with tone length d.
%INPUT
%   d = length of each tone in seconds.
%   filename = string which must end on .wav.

%OUTPUT
%   z = array of different frequencies all of length d.
%   if filename given: .wav file of z.
fs = 44100;
n = round(d*fs);
t = (0:n-1)'/fs;

freqs = exp(linspace(log(100), log(9000), 40)); %tones increase 
% exponentially in frequency.

x = [];

for i=1:length(freqs)
    x = [x; cosgate(sin(2*pi*freqs(i)*t), fs, 10e-3); zeros(round(50e-3*fs),1)];
end

x = .98*x/max(abs(x)); %converts x to a loudness scale of 0 to 0.98.

if nargin>1 %Only saves file when filename is given.
    audiowrite(filename, x, fs);
end

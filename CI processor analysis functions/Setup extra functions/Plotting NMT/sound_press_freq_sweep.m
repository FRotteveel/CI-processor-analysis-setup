function [dB] = sound_press_freq_sweep(L)
%Creates an 22x1 array [dB] of the sound pressure levels of the different
%frequencies.
%Input:
%   L = loudness level, should be between 0 and 1.
%Output:
%   dB = an 22x1 array of sound pressure level of the frequency sweep.
d = 0.5;
[z] = freq_sweep(d, L);
dB = [];
dB(1) = 20*log10(rms(z(1:(d*44100))));
for i = 1:21
    dB(i+1) = 20*log10(rms(z((i*d*44100):((i+1)*d*44100))));
end
dB = dB';
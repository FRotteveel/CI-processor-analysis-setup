[x, fs, freqs] = freq_sweep(70e-3);

n = 10;
x = [zeros(1024,1); .9*ones(n,1); -.9*ones(n,1); zeros(round(50e-3*fs),1); x];

audiowrite('IMG10001.wav', x, fs);


% plot(freqs, '-o')

p = audioplayer(x, fs, 24);
play(p);


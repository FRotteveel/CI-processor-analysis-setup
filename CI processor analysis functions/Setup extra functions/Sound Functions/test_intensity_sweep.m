hr90k = [250,416,494,587,697,828,983,1168,1387,1648,1958,2326,2762,3281,3898,4630,8700];
hr90k = interp1(hr90k, linspace(1,17,16));
nchannel = 11;

[x, fs, L] = intensity_sweep(70e-3,sqrt(hr90k(nchannel)*hr90k(nchannel+1)));

n = 10;
x = [zeros(1024,1); .9*ones(n,1); -.9*ones(n,1); zeros(round(50e-3*fs),1); x];

audiowrite('IMG10003-ch11.wav', x, fs);


% plot(freqs, '-o')

p = audioplayer(x, fs, 24);
play(p);


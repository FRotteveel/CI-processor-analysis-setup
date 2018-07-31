snd_path = '~/Sounds/Dutch_CV/processed';

%syll = 'b3';
syll = 'vi';

%f0 = [117, 127, 137, 148, 156, 167, 175, 189, 197, 207, 218, 227, 237, 248, 258, 337];

x = [];

fname = fullfile(snd_path, sprintf('%s_GPR*_SER1.00_D200.*', syll));
lst = dir(fname);

sel = round(linspace(1,length(lst),20));

for i=1:length(sel)
    fname = fullfile(snd_path, lst(sel(i)).name);
    [y, fs] = audioread(fname);
    x = [x; y; zeros(round(30e-3*fs),1)];
    x = [x; y; zeros(round(30e-3*fs),1)];
end

p = audioplayer(x, fs, 24);
play(p)

audiowrite('IMG10005-vi-f0.wav', x, fs);
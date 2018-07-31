function y = processwvf(filename)
%Takes a waveform (wvf) file from the DL750 Scopecorder and processes it
%into a sort of electrodograph with 16 channels. The channels are numbered
%from top to bottom
%NB!: the wvfread functions should be installed

%INPUT
%   filename: a .wvf file which should be produced by the DL750 Scopecorder
%OUTPUT
%   plot of an electrodograph

y = wvfreadall(filename);
plotalltraces2(y);
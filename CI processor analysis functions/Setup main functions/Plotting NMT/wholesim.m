function wholesim(d, L, channel)
%This is a main function which calls other sub-functions. It will
%create an audiofile which will be processed using the ACE_map simulation
%and then the output of this will be processed creating electrodographs and
%current-dB graphs.

%Will not work with edge channels!

%INPUT:
%   d = time length of each frequency.
%   L = loudness of the audiofile. Must be a value between 0 and 1.
%   channel = the desired channel to plot the current-dB graph

%OUTPUT:
%   plot of electrodograph.
%   plot of dB-current graph
%   q = processed .wav file

%Set of sounds (creates an audiofile)
freq_sweep(d, L);

%Implant processing
p = ACE_map;

%Load board (q = ..)
q = Process(p, 'freq_sweep.wav');

%signal processing (electrodographs and current-dB graphs)
figure;
Plot_sequence(q, 'ACE map');
dB_current3(channel, d);
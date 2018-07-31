function [p,q] = ace_plot(audiofile)
%creates an electrodograph of an audiofile with the ACE strategy
%Input:
%   audiofile: .wav file of the audiofile
%Output: 
%   Plot of electrodograph

p = ACE_map; %determines processing strategy and parameters.
q = Process(p, audiofile); %Processes audiofile
Plot_sequence(q, 'ACE map'); %Plots the audiofile, with 'ACE map' as title/
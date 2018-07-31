function q = signal2struct(filename)
%Converts the structure created by wvfreadall.m into a structure usable for
%Plot_sequence.m from the Nucleus Matlab Toolbox.

%Reads the signal and stores it into different channels.
y = wvfreadall(filename);

%Finds the peaks and peak heights of all channels.
u = peakinfo(y);

%Puts all channels together and sorts them, calculates q.periods.
q = fusechannels(y, u);
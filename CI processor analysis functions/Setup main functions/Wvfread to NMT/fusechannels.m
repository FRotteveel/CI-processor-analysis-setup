function q = fusechannels(y, u)
%This function takes the structure of peakinfo u and struct y. The structure is
%converted into the structure of Process from NMT. 

%Input:
%   y = struct, output of the wvfreadall.m function.
%   u = struct, output of the peakinfo.m function.

%Output:
%   q = struct, consisting of q.currrent_levels, q.electrodes and
%       q.periods. This structure is in the form of Process.m, required for 
%       using the NMT function Plot_sequence, used for plotting 
%       electrodograms.

M = [];
T = [];
E = [];
for i = 1:16
    chan_name = sprintf('Channel%d',i);
    if isfield(u, chan_name) %checks if the channel exists.
        peakarr = [u.(chan_name).pos_peak_heights;abs(u.(chan_name).neg_peak_heights)];
        m = mean(peakarr); %takes the mean of the positive and negative peak heights.
        M = [M, m]; %adds all magnitudes (peak heights) to vector M.
        T = [T, u.(chan_name).min_locs1]; %adds all indices of pulse beginnings to vector T.
        E = [E, i.*ones(1,length(u.(chan_name).min_locs1))]; %creates a vector which includes all channel numbers.
    end
end

[t, i] = sort(T); %sorts the indices in ascending order.
q.current_levels = M(i); %sorts vector M in the same order as T.
q.electrodes = E(i); %sorts vecotr E in the same order as T.

ts = y.Group1.Trace1.t(t)*10^6; %takes the times in microseconds.

q.periods = [diff(ts);0]; %periods is difference in time signatures in microseconds.

q.current_levels = q.current_levels'; %flips the vector.
q.electrodes = q.electrodes'; %flips the vector.
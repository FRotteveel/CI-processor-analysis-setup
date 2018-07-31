function [u] = peakinfo(y)
%Finds the indices and magnitudes of the peaks of the struct y, processed by
%wvfreadall. The information is stored in struct u.

%INPUT:
%   y = struct, output of the wvfreadall function.
%OUTPUT:
%   u = struct, containing information about the analysed signals of y.
%       u is divided into the different channels present in y (called
%       (chan_name).
%           u.(chan_name).pulse_t = the time of the beginning of each pulse
%           , it is assumed that each pulse complex starts with a negative
%           pulse and has no phase gap.
%           u.(chan_name).neg_phase_widths = the difference between the
%           first negative and positive pulses of the derivative of the
%           signal.
%           u.(chan_name).pos_phase_widths = the difference between the
%           positive pulse and the second negative pulse of the derivative 
%           of the signal.
%           u.(chan_name).neg_phase_heigths = average heights of the
%           negative pulses.
%           u.(chan_name).pos_phase_heights = average heights of the
%           positive pulses.


for G = 1:4
    for T = 1:4 %go through all groups and channels.
        group_num = sprintf('Group%d',G); %string of group number.
        trace_num = sprintf('Trace%d',T); %string of trace number.
        if isfield(y, group_num) && isfield(y.(group_num),trace_num) %evaluates if a channel is present.
            chan_num = (G - 1)*4 + T; %converts group and trace numbers to channel numbers.
            fprintf('Processing Channel %d. \n', chan_num);
            chan_name = sprintf('Channel%d',chan_num);
            [max_locs_cleaned,min_locs1, min_locs2] = find_peak_locs(y, group_num, trace_num);
            
%             u.(chan_name).neg_phase_widths = [];  %%Not used by
%             u.(chan_name).pos_phase_widths = [];
%             for i = 1:length(max_locs_cleaned)
%                 u.(chan_name).neg_phase_widths(i) = max_locs_cleaned(i) - min_locs1(i);
%                 u.(chan_name).pos_phase_widths(i) = min_locs2(i) - max_locs_cleaned(i);
%             end
            
            [pos_peak_heights, neg_peak_heights] = find_peak_heights(y, group_num, trace_num, min_locs1, min_locs2, max_locs_cleaned);
            u.(chan_name).pos_peak_heights = pos_peak_heights;
            u.(chan_name).neg_peak_heights = neg_peak_heights;
            u.(chan_name).min_locs1 = min_locs1;
%             u.(chan_name).min_locs2 = min_locs2; %%Not used
%             u.(chan_name).max_locs = max_locs_cleaned;
            fprintf('Done. \n');
        end
    end
end
            
function [pos_peak_heights, neg_peak_heights] = find_peak_heights(y, group_num, trace_num, min_locs1, min_locs2, max_locs_cleaned)
% Finds the heights of the peaks of the locations mini_locs and maxi_locs.

%Input:
%   y = struct, output of the wvfreadall.m function.
%   group_num = string, indication of the current group.
%   trace_num = string, indication of the current trace.
%   min_locs1 = vector of indices of the first negative peaks of the
%               derivative of the read signal.
%   min_locs2 = vector of indices of the second negative peaks of the
%               derivative of the read signal.
%   max_locs_cleaned = vector of indices of the positive peaks of the
%               derivative of the read signal.

%Output:
%   pos_peak_heights = vector of mean heights of the positive peaks of the 
%                      read signal. The peak height is determined by taking
%                     the indices of the first negative and the positive
%                     peak locations of the derivative of the signal. Only
%                     the middle third of the distance between the indices is
%                     taken. The average of the heigths of the remaining
%                     part of the signal is taken.
%                           
%   neg_peak_heights = vector of mean heights of the negative peaks of the 
%                      read signal. The same as for positive peak heigths,
%                      except the difference between the positive and the
%                      second negative peak of the derivative is taken.

pos_peak_heights = [];
neg_peak_heights = [];
for i = 1:length(max_locs_cleaned)
    pos_peak_heights(i) = mean(y.(group_num).(trace_num).Block1(max_locs_cleaned(i) + round(abs((min_locs2(i)-max_locs_cleaned(i))/3)):min_locs2(i) - round(abs((min_locs2(i)-max_locs_cleaned(i))/3))));
    neg_peak_heights(i) = mean(y.(group_num).(trace_num).Block1(min_locs1(i) + round(abs((max_locs_cleaned(i) - min_locs1(i))/3)):max_locs_cleaned(i) - round(abs((max_locs_cleaned(i) - min_locs1(i))/3))));
end
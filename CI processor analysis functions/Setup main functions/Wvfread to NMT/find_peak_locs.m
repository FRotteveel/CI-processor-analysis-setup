function [max_locs_cleaned, min_locs1, min_locs2] = find_peak_locs(y, group_num, trace_num)
%Finds the temporal locations of the maximum peaks of the derivative of a
%wvfreadall.m struct.

%Input:
%   y = struct, output of the wvfreadall.m function.
%   group_num = string, indication of the current group.
%   trace_num = string, indication of the current trace.

%Output:
%   max_locs_cleaned = vector of indices of the positive peaks of the
%               derivative of the read signal. The peaks are found by
%               setting the threshold at 10% of the maximum peak. Then, only
%               peaks which have a negative peak before and after the
%               positive peak, within a range of k are saved. This ensures that only proper peak
%               complexes are saved. 
%               k is a range of 50 microseconds.
%   min_locs1 = vector of indices of the first negative peaks of the
%               derivative of the read signal. The peaks are found by
%               taking the inverse of the derivative and setting the
%               threshold at 10% of the maximum peak. Only peaks which are
%               in the peak complexes, described in max_locs_cleaned, are
%               saved. min_locs1 is the peak before the positive peak
%   min_locs2 = vector of indices of the second negative peaks of the
%               derivative of the read signal. min_locs2 is the peak after 
%               the positive peak.

fs = 500000;
k = fs*10^-6*50;

diff1 = diff(y.(group_num).(trace_num).Block1); %takes the first derivative of the signal
diff1(end+1) = 0; %adds a 0 at the end of the array to keep it the same length.
[~,max_locs] = findpeaks(diff1, 'Minpeakheight', max(diff1)/10); %finds the peaks which are higher than 1/3 of the maximum peak.

inv_diff1 = -diff1; %inverted, to evaluate the negative peaks.
[~ ,min_locs] = findpeaks(inv_diff1, 'Minpeakheight', max(inv_diff1)/10); %finds the peaks which are higher than 1/3 of the maximum peak.

max_locs_cleaned = [];
min_locs1 = [];
min_locs2 = [];
for i = 1:length(max_locs)
    s1 = (min_locs >= max_locs(i) - k) & (min_locs < max_locs(i)); %checks if there are any min_locs in the range k before max_locs(i)
    s2 = (min_locs <= max_locs(i) + k) & (min_locs > max_locs(i)); %same as above but then after max_locs(i)
    if any(s1) && any(s2) %evaluates if there are any ones in s1 and s2
        max_locs_cleaned = [max_locs_cleaned, max_locs(i)]; %only positive peaks which are in between two negative peaks are saved.
        min_locs1 = [min_locs1, max(min_locs(s1))];
        min_locs2 = [min_locs2, max(min_locs(s2))];
    end
end

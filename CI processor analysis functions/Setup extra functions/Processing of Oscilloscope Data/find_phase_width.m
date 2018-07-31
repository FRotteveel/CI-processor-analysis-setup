function [phase_width, phase_gap] = find_phase_width(maxi_locs, mini_locs)
%finds the phase widths and gap widths of the signal 

phase_width = 0;
phase_gap = 0;

for i = 2:length(mini_locs)
    single_phase = mini_locs(i) - maxi_locs(i);
    phase_width = phase_width + single_phase;
    single_gap = maxi_locs(i) - mini_locs(i-1);
    phase_gap = phase_gap + single_gap;
end 

phase_width = phase_width/(length(mini_locs)-1);
phase_gap = phase_gap/(length(mini_locs)-1);
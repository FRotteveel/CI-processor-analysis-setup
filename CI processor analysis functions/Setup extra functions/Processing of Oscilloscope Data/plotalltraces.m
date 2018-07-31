function plotalltraces(y)
%Plots all channels of the DL750 oscilloscope under each other as subplots.


%INPUT:
%   y: a struct made by wvfreadall.m
%OUTPUT:
%   plot of a sort of electrodogram

minimum = 0;
maximum = 0;
for G = [1:4]       %This for loop figures out the maximum and minimum
    for T = [1:4]   %value which exist in y.
        group_num = sprintf('Group%d', G);
        trace_num = sprintf('Trace%d', T);
        m = max(y.(group_num).(trace_num).Block1);
        l = min(y.(group_num).(trace_num).Block1);
        if maximum < m;
            maximum = m;
        end
        if minimum > l;
            minimum = l;
        end
    end
end

figure
for G = [1:4]
    for T = [1:4]
        subplot(16,1,((G-1)*4 + T));%create 16 vertically stacked subplots.
        group_num = sprintf('Group%d', G);
        trace_num = sprintf('Trace%d', T);
        plot(y.(group_num).(trace_num).t,y.(group_num).(trace_num).Block1);             
        axis([min(y.(group_num).(trace_num).t) max(y.(group_num).(trace_num).t) minimum maximum]);
        if G == 4 && T == 4 
            set(gca,'YTICK', []) %removes ylabel for the last channel.
        else 
            set(gca,'XTick',[], 'YTICK', []) %removes xlabel and ylabel for all other channels.
            
        end
    end
end

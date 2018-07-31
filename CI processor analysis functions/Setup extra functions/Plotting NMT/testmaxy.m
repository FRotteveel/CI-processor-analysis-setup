function [minimum, maximum] = testmaxy(y)

minimum = 0;
maximum = 0;
for G = [1:4]
    for T = [1:4]
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
minimum;
maximum;
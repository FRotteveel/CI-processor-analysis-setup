function dB_current(channel)
%Creates a plot of current level against sound pressure level in dB values
%of the desired channel of a frequency sweep audio file.

%INPUT:
%   channel = which channel should be plotted. (The two adjacent channels
%   are also plotted.

%OUTPUT:
%   plot of current level - sound pressure level (dB)

p = ACE_map;

channel_index = find(p.electrodes==channel,1);
f = p.char_freqs(channel_index);

fs = 44100;
d  = .5;
t = (0:round(d*fs))/fs; %Determines the time of each frequency
x = cosgate(sin(2*pi*f*t), fs, 50e-3); %the cosgate function smooths out
%the edges of each tone.

current_below = [];
current = [];
current_above = [];

dB = -80:1:0; %dB range

for i = 1:length(dB)
    y = x*10^(dB(i)/20);
    audiowrite('tmp.wav', y, fs);
    q = Process(p, 'tmp.wav');
    t = Get_pulse_times(q);
    
    s = q.electrodes==channel;
    k = q.current_levels(s);
    t_channel = t(s);
    current(i) = mean(k(t_channel>.1 & t_channel<t(end)-.1));
    
    s = q.electrodes==channel-1; % Won't work for edge channels
    k = q.current_levels(s);
    t_channel = t(s);
    current_below(i) = mean(k(t_channel>.1 & t_channel<t(end)-.1));
    
    s = q.electrodes==channel+1; % Won't work for edge channels
    k = q.current_levels(s);
    t_channel = t(s);
    current_above(i) = mean(k(t_channel>.1 & t_channel<t(end)-.1));
    
end

figure(1)
plot(dB, current,'*-');
hold on
plot(dB, current_below,'x-');
plot(dB, current_above,'o-');
xlabel('Sound Pressure Level (dB)')
ylabel('Current Level');
hold off

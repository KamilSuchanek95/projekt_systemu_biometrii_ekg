function [R2] = detect_Rs(signal)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
dt = 0.002;
% Fs = 1/0.002;
s=signal;
s = s.^2;
s = diff(s);
m_frame = 24 /1000; % [ms]
s = movmean(s, m_frame/dt);
s(s<0) = 0;
th=10*mean(s);
R = [];
for i = 3:numel(s)-2
    if s(i) > s(i-1) && s(i) > s(i+1) && s(i) > th
        R(end+1, 1) = i;
    end
end
R2 = [];
for i = 1:numel(R)
    j = R(i);
    one = find(signal(j:j+25) == max(signal(j:j+25)));
    R2(end+1,1) = one(1) + j - 1;
end


%%
% time = 0:dt:dt*(numel(signal)-1);
% plot(time, signal);hold on;
% plot(time(R), signal(R), 'r*');
% plot(time, [0; s]);
% plot(time(R2), signal(R2), 'm*');
end
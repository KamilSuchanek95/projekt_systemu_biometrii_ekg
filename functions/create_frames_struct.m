function [frames] = create_frames_struct(r, R)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    frames = struct();
    for person_numer = 1:numel(fieldnames(r))
        person = sprintf('person_%i', person_numer);
        frames.(person) = [];
        for record_numer = 1:numel(fieldnames(r.(person)))
            record = sprintf('record_%i', record_numer);
            n = numel(r.(person).(record).filtered);
            for R_numer = 1:numel(R.(person).(record))
                from = R.(person).(record)(R_numer)-80;
                to = R.(person).(record)(R_numer)+170;
                if from > 0 && to < n
                    frames.(person)(1:251,end+1) = r.(person).(record).filtered(from:to);
                end
            end
        end
    end
% n = numel(signal);
% for i = 1:numel(R)
%     from = R(i)-80; to = R(i)+170;
%     if from > 0 && to < n
%         frames(1:251, end+1) = signal(from:to);
%     end
% end
end


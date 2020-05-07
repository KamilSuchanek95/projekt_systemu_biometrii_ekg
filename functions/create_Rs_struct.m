function [R] = create_Rs_struct(r)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    R = struct();
    for person_numer = 1:numel(fieldnames(r))
        person = sprintf('person_%i', person_numer);
        for record_numer = 1:numel(fieldnames(r.(person)))
            record = sprintf('record_%i', record_numer);
            R.(person).(record) = detect_Rs(r.(person).(record).filtered);
        end
    end
end


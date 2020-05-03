clc;clear;close all;
%% load data from csv to Workspace
persons = dir('C:\Users\kamis\Desktop\dane ecg-id csv');
persons = persons(3:end); % struktura z folderami osób (osoba_1, osoba_2...)
for n_of_person = 1:numel(persons) % pêtla po osobach _1, _2 ...
    records = dir([persons(n_of_person).folder '\' persons(n_of_person).name]);
    records = records(3:end); % struktura z rekordami (record_1...)
    for n_of_record = 1:numel(records) % pêtla po rekordach _1, _2...
        % utworzenie nazwy path
        input_file_path = sprintf('%s\\%s',records(n_of_record).folder,records(n_of_record).name);
        % za³adowanie danych z .csv do zmiennych
        [raw, filtered] = specifically_load_from_csv(input_file_path);
        per = sprintf('person_%i', n_of_person); % tekst dla pola tworzonej struktury
        rec = sprintf('record_%i', n_of_record); % tak samo
        r.(per).(rec).filtered = filtered; % ³adowanie danych do struktury
        r.(per).(rec).raw = raw; % tak samo
        r.(per).(rec).period = 0.002; % a to zak³adamy takie samo dla wszystkich
        r.(per).(rec).units = 'periods [s], amplitude [mV]'; % -||-
        
    end
end
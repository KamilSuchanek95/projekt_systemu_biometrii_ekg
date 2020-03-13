%% Generowanie struktur danych

osoby = dir('dane csv');
osoby = osoby(3:end); % struktura z folderami osób (osoba_1, osoba_2...)
for numOs = 1:numel(osoby) % pêtla po osobach _1, _2 ...
    rekordy = dir([osoby(numOs).folder '\' osoby(numOs).name]);
    rekordy = rekordy(3:end); % struktura z rekordami (record_1...)
    for numRek = 1:numel(rekordy) % pêtla po rekordach _1, _2...
        % utworzenie nazwy path
        input_file_path = sprintf('%s\\%s',rekordy(numRek).folder,rekordy(numRek).name);
        % za³adowanie danych z .csv do zmiennych
        [raw, filtered] = specifically_load_from_csv(input_file_path);
        os = sprintf('person_%i', numOs); % tekst dla pola tworzonej struktury
        rek = sprintf('record_%i', numRek); % tak samo
        records.(os).(rek).filtered = filtered; % ³adowanie danych do struktury
        records.(os).(rek).raw = raw; % tak samo
        records.(os).(rek).period = 0.002; % a to zak³adamy takie samo dla wszystkich
        records.(os).(rek).units = 'periods [s], amplitude [mV]'; % tak samo
        clear filtered raw % wyczyszczenie, s¹ nadpisywanie i tak
    end
end
clear input_file_path os rek osoby rekordy numOs numRek
%% Zestawienie sygna³ów autorów, sk¹d dane zaczerpnêliœmy:

% r = records.person_1.record_1;
% time = 0:r.period:r.period*(length(r.filtered) - 1);
% plot(time, r.raw); hold all;
% plot(time, r.filtered);
% legend('surowy','przefiltrowany');
% title('Zestawienie sygna³u surowego oraz po filtracji');
% xlabel('czas [s]'); ylabel('amplituda [mV]');

%% Filtracja
%Hd = filtration;
load('filtr dolno.mat');
load('filtr gorno.mat');
r = records.person_1.record_1;
filtered_now = filter(Hd_lowpass, r.raw);
filtered_h = filter(Hd_highpass, filtered_now);

time = 0:r.period:r.period*(length(filtered_now) - 1);
time_h = 0:r.period:r.period*(length(filtered_now) - 500);
figure();
plot(time, r.raw); hold all;
plot(time_h, filtered_h(500:end));
legend('surowy','przefiltrowany');
title('Zestawienie sygna³u surowego oraz po filtracji');
xlabel('czas [s]'); ylabel('amplituda [mV]');
% plot(time_h(time_h>6 & time_h<6),filtered_h(500+find(time_h>6 & time_h<6)))
% plot(time_h(time_h>6 & time_h<8),filtered_h(500+find(time_h>6 & time_h<8)))
% hold on;plot(time(time>6 & time<8),r.raw(find(time>6 & time<8)))
%% Okienkowanie

% detekcja R
figure()
s = filtered_h;
s1 = s; s1(s1<0) = 0; 
plot(time, s1)
hold on;
threshold =  max(s1)/2;
thresholds = threshold * ones(size(time));
plot(time, thresholds)
R = [];
for i = 1:length(s1)-1
    if threshold<s(i)
        if s(i+1)<s(i) & s(i-1)<s(i)
            R(end+1) = i;
        end
    end
end
hold on;
plot(time(R), s1(R), '*r')













addpath('functions')
%% Okienkowanie
% 80<- R ->170
% detekcja R
clear;clc
% load('records with data from Physionet.mat');
% R = create_Rs_struct(r);
% f = create_frames_struct(r, R);
load('f r R load.mat');
%% wizualne sprawdzenie wykrytych za³amków R
dt = 0.002;
t = 0:dt:dt*(numel(r.person_1.record_1.filtered)-1);
for i = 1:numel(fieldnames(r)) % osoby...
    person = sprintf('person_%i', i);
    for j = 1:numel(fieldnames(r.(person))) % rekordy...
        record = sprintf('record_%i', j);
        figure('Position', [0 0 1000 600])
        plot(t, r.(person).(record).filtered); hold on; % 
        plot(t(R.(person).(record)), r.(person).(record).filtered(R.(person).(record)), 'r*')
        str = sprintf('{r.%s.%s} continue? [enter]', person, record);
        input(str)
        close
    end
end

%% przegladanie wysegmentowanych okienek
for i = 1:numel(fieldnames(f))
    person = sprintf('person_%i', i);
    plot(f.(person))
    str = sprintf('{f.%s} continue? [enter]', person);
    input(str)
    close
end

%% podzia³ na zbiory uczacy i testowy
test = struct(); train = struct();
for i = 1:numel(fieldnames(f))
    person = sprintf('person_%i', i);
    num = size(f.(person), 2);
    num2 = ceil(num/2); num1 = ceil(num/2) - 1;
    test.(person)(1:251, 1:num1) = f.(person)(:,1:num1);
    train.(person)(1:251, 1:num2) = f.(person)(:,1:num2);
end

%%


















% %% Filtracja
% %Hd = filtration;
% load('filtr dolno.mat');
% load('filtr gorno.mat');
% rek = r.person_1.record_1;
% filtered_now = filter(Hd_lowpass, rek.raw);
% filtered_now = filter(Hd_highpass, filtered_now);
% 
% time = 0:rek.period:rek.period*(length(filtered_now) - 1);
% time_h = 0:rek.period:rek.period*(length(filtered_now) - 500);
% figure();
% plot(time, rek.raw); hold all;
% plot(time_h, filtered_now(500:end));
% legend('surowy','przefiltrowany');
% title('Zestawienie sygna³u surowego oraz po filtracji');
% xlabel('czas [s]'); ylabel('amplituda [mV]');




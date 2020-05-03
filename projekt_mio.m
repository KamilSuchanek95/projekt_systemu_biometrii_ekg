%% Okienkowanie
% 80<- R ->170
% detekcja R
signal = r.person_1.record_1.filtered;
R = detect_Rs(signal);
%%
frames = [];
n = numel(signal);
for i = 1:numel(R)
    from = R(i)-80; to = R(i)+170;
    if from > 0 && to < n
        frames(end+1, 0:249) = signal(from:to);
    end
end



















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




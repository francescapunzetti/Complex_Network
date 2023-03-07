clear;
clc;
clearvars;

T = readmatrix('dataPat_4.csv'); %read the table
col1 = T(:, 10); %select a node
col2 = T(:, 2);
time = 0:0.002:14.398; %create time array for each istant
% plot(time, col1);
% tl = tiledlayout(8,8);
% for k = 1:64
%     nexttile(tl)
% %     subplot(8,8, k)
%     col = T(:, k);
%     plot(time, col); %plot the signal of node along time
%     ylim([-0.025 0.025])
%     title(k)
% end
% title(tl, 'Electrodes signal')
% xlabel('Time instant [s]')
% ylabel('Signal')

% check the preprocessing via Fourier analysis
tl = tiledlayout(8,8);
for k = 1:64
    nexttile(tl)
%     subplot(8,8, k)
    col = T(:, k);
    y = fft(col);
    fs = 500;
    f = (0:length(y)-1).*fs/length(y);
    plot(f,abs(y))
    ylim([0 5])
    title(k)
end
title(tl, 'Fourier analysis')
% xlabel('Frequency [Hz]')
% ylabel('Magnitude')
% 
% y = fft(col1);
% fs = 500;
% f = (0:length(y)-1).*fs/length(y);
% plot(f,abs(y))
% xlabel('Frequency (Hz)')
% ylabel('Magnitude')
% title('Magnitude')


%% READ_EMG
clear all; close all; clc;

[file,~] = uigetfile('*.txt','Choose gait or jump');
file = file(1:4);
EMG_txt = dlmread(strcat(file,'_EMG.txt'));
RMS_txt = dlmread(strcat(file,'_RMS.txt'));

if strcmp(file,'GAIT')
    Time = EMG_txt(:,1);
    EMG = EMG_txt(:,2:5)*10^6;
    RMS = RMS_txt(:,2:5)*10^6;
else
    Time = EMG_txt(71:end-90,1);
    EMG = EMG_txt(71:end-90,2:5)*10^6;
    RMS = RMS_txt(71:end-90,2:5)*10^6;
end 


motion_percentage = (Time - Time(1,1))/(Time(end,1)-Time(1,1)) * 100;
muscles = [' Gastrocnemius Medialis, Tibialis Anterior, Rectus Femoris, Biceps Femoris'];
muscles_names = strsplit(muscles,',');

% Plot Raw EMG
for i = 1:4
    figure
    plot(motion_percentage,EMG(:,i))
    title(strcat(file,' - EMG - ',muscles_names(i)))
    xlabel('% of Motion')
    ylabel('EMG')
end

% Plot RMS
for i = 1:4
    figure
    plot(motion_percentage,RMS(:,i))
    title(strcat(file,' - RMS - ',muscles_names(i)))
    xlabel('% of Motion')
    ylabel('RMS')
end

%% GAIT - Plots to Report
% Normalization
muscle_means = mean(RMS);
normalized_RMS = RMS./muscle_means * 100;
ylims = [0 400;0 450; 0 400;0 400];
figure
for i = 1:2
    subplot(2,1,i)
    plot(motion_percentage,normalized_RMS(:,i),'LineWidth',2)
    title(strcat(file,' - RMS - ',muscles_names(i)))
    xlabel('% of Motion')
    ylabel('Normalized EMG (%)')
    legend(strcat('Mean(uV)=',num2str(muscle_means(i))))
    ylim(ylims(i,:))
end

figure
for i = 3:4
    subplot(2,1,i-2)
    plot(motion_percentage,normalized_RMS(:,i),'LineWidth',2)
    title(strcat(file,' - RMS - ',muscles_names(i)))
    xlabel('% of Motion')
    ylabel('Normalized EMG (%)')
    legend(strcat('Mean(uV)=',num2str(muscle_means(i))))
    ylim(ylims(i,:))
end


%% JUMP - Plots to Report

% Processing Raw to RMS according to literature

% Filtration
fs = 100;
fpass = 10;
order = 10;
[b,a] = butter(order,0.2,'high');
EMG_filtered = filter(b,a,EMG);

% RMS (has to have 0.1s of time window - then, as fs =
% 100HZ, dim window = 10)
dim_window = 10;
movRMS = dsp.MovingRMS(dim_window);
EMG_RMS = movRMS(EMG_filtered);

% Normalization
muscle_MVC = [130 350 80 50];
EMG_normalized_RMS = EMG_RMS./muscle_MVC * 100;
ylims = [0.6 400.6;0.5 150.5; 0.6 150.6;-50 200];

% Plotting
for i = 1:4
    figure
    plot(motion_percentage,EMG_normalized_RMS(:,i))
    title(strcat(file,' - RMS - ',muscles_names(i)))
    xlabel('% of Motion')
    ylabel('MVC(%)')
    legend(strcat('MVC(uV)=',num2str(muscle_MVC(i))))
    ylim(ylims(i,:))
end
%% JUMP - Plots to Report

% Normalization
muscle_MVC = [130 350 250 80];
normalized_RMS = RMS./muscle_MVC * 100;
ylims = [0.6 400.6;0.5 150.5; 0.6 150.6;-50 200];
figure
% Plotting
for i = 1:2
    subplot(2,1,i)
    plot(motion_percentage,normalized_RMS(:,i),'LineWidth',1.5)
    title(strcat(file,' - RMS - ',muscles_names(i)))
    xlabel('% of Motion')
    ylabel('MVC(%)')
    legend(strcat('MVC(uV)=',num2str(muscle_MVC(i))))
    ylim(ylims(i,:))
    %line(xlim,[0,0],'Color','k','LineStyle',':')
end
figure
for i = 3:4
    subplot(2,1,i-2)
    plot(motion_percentage,normalized_RMS(:,i),'LineWidth',1.5)
    title(strcat(file,' - RMS - ',muscles_names(i)))
    xlabel('% of Motion')
    ylabel('MVC(%)')
    legend(strcat('MVC(uV)=',num2str(muscle_MVC(i))))
    ylim(ylims(i,:))
    %line(xlim,[0,0],'Color','k','LineStyle',':')
end

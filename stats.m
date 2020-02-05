clear
clc

%% Read in data from Excel
initdata = readtable('time.xlsx');
data = initdata{2:end,2:end};

%% Initialize Constants
dist = 4; %meters
elderly_speed = 0.8; %m/s
adult_speed = 1.4; %m/s
child_speed = 0.9; %m/s
elderly_type = 25; %characters per minute
adult_type = 250; %characters per minute
child_type = 125; %characters per minute
code = 5; %4 digit PIN and enter key

%% Stats
conf = 0.95;
sample_mean = [];
sample_std = [];
sample_median = [];
sample_var = [];

for i = 1:5
    mean_time = mean(data(:,i));
    sample_mean = [sample_mean mean_time];
    std_dev = std(data(:,i));
    sample_std = [sample_std std_dev];
    median_time = median(data(:,i));
    sample_median = [sample_median median_time];
    variance = var(data(:,i));
    sample_var = [sample_var variance];
    



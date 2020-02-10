clear
clc

%% Read in data from Excel

initdata = readtable('time.xlsx');
data = table2cell(initdata(2:end,2:end));
[num,txt] = xlsread('time.xlsx')

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

p = 0.95;
sample_mean = [];
sample_std = [];
sample_median = [];
sample_var = [];
conf_int = [];
prec_int = [];
num_meas = [];
d = (10/60)/2;

for i = 2:6
    N = length(num(:,i)); %length of vector
    norm = num(:,i)./5;
    mean_time = mean(norm); %average time per character
    sample_mean = [sample_mean mean_time]; %storing average time in vector
    std_dev = std(norm); %standard deviation of time per character
    sample_std = [sample_std std_dev]; %storing std dev in vector
    median_time = median(norm); %median of time per character
    sample_median = [sample_median median_time]; %storing median in vector
    variance = var(norm); %variance of time per character
    sample_var = [sample_var variance]; %storing variance in vector
    t = tinv(p,N-1); %students distribution
    sx_bar = std_dev/sqrt(N); %calc for CI
    ci = t*sx_bar; % confidence interval
    conf_int = [conf_int ;-ci ci]; % storing confidence interval
    preci = t*std_dev; % precision interval
    prec_int = [prec_int; -preci preci]; %storing precision interval
    num = (ci/d)^2; %number of measurements needed to obtain desired CI
    num_meas = [num_meas num]; %storing number of measurements needed
end



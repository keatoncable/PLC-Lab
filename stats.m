clear
clc

%% Read in data from Excel

%initdata = readtable('time.xlsx');  %reads data from spreadsheet
%data = table2cell(initdata(2:end,2:end));   %sorts data
[num,txt] = xlsread('time.xlsx');   %reads data from excel

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
cistore = [];
pistore = [];
d = (10/2);

for i = 2:6
    N = length(num(:,i)); %length of vector
    norm = num(:,i)./code; %normalizes times to per character
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
    nummeas = (ci/d)^2; %number of measurements needed to obtain desired CI
    num_meas = [num_meas nummeas]; %storing number of measurements needed
end

elderly_walk = elderly_speed*dist; %calculating elderly walk time
adult_walk = adult_speed*dist; %calculating adult walk time
child_walk = child_speed*dist; %calculating child walk time

elderly_time = mean(elderly_type.*sample_mean); %calculating time needed for elderly to input 5 digits
adult_time = mean(adult_type.*sample_mean); %calculating time needed for adult to input 5 digits
child_time = mean(child_type.*sample_mean); %calculating time needed for child to input 5 digits

elderly_sum = elderly_walk+elderly_time;
adult_sum = adult_walk+adult_time;
child_sum = child_walk+child_time;

%% Build tables

statstable = {'' 'Sample Mean' 'Sample Standard Deviation' 'Sample Median' 'Sample Variance';
        'Test 1' sample_mean(1) sample_std(1) sample_median(1) sample_var(1);
        'Test 2' sample_mean(2) sample_std(2) sample_median(2) sample_var(2);
        'Test 3' sample_mean(3) sample_std(3) sample_median(3) sample_var(3);
        'Test 4' sample_mean(4) sample_std(4) sample_median(4) sample_var(4);
        'Test 5' sample_mean(5) sample_std(5) sample_median(5) sample_var(5)}
    
    xlswrite('stats.xlsx',statstable,1)
    
for k = 1:5
    cisto = sprintf('[%.3f , %.3f]',conf_int(k,1),conf_int(k,2));
    cistore = [cistore string(cisto)];
    pisto = sprintf('[%.3f , %.3f]',prec_int(k,1),prec_int(k,2));
    pistore = [pistore string(pisto)];
end
 
intervals = {'' 'Confidence Interval' ' Precision Interval';
            'Test 1' cistore{1} pistore{1};
            'Test 2' cistore{2} pistore{2};
            'Test 3' cistore{3} pistore{3};
            'Test 4' cistore{4} pistore{4};
            'Test 5' cistore{5} pistore{5};}
        
        xlswrite('intervals.xlsx',intervals,1)
        
 numneeded = {'' 'Number of Measurements to Obtain CI';
            'Test 1' num_meas(1);
            'Test 2' num_meas(2);
            'Test 3' num_meas(3);
            'Test 4' num_meas(4);
            'Test 5' num_meas(5)}
        
        xlswrite('numneeded.xlsx',numneeded,1)
        
results = {'' 'Time Needed to Input Code' 'Time Needed to Walk to Keypad' 'Total Alarm Time Needed';
            'Elderly'   elderly_walk elderly_time elderly_sum;
            'Adult'     adult_walk adult_time adult_sum;
            'Child'     child_walk child_time child_sum}
        
        xlswrite('results.xlsx',results,1)
        
            
        
        
        
        
        
        

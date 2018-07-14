%%
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

% filename=['.\data_new\1-Deep-Area\1\cdn_predict_evaluate.csv'];
% data=csvread(filename,1,1);
% nums=data(:,3);
% errors=data(:,2);
% mean_error=sum(errors.*nums)/sum(nums);
% disp(mean_error)

filename='.\data_new\result\0\55-4-W_soft0_deeploc_testResult.txt';
data=load(filename);
nums=data(:,2);
errors=data(:,3);
mean_error=sum(errors.*nums)/sum(nums);
disp(mean_error)

% filename=['.\data_new\result\2\cdn_predict_evaluate.csv'];
% data=csvread(filename,1,1);
% nums=data(:,3);
% errors=data(:,2);
% mean_error=sum(errors.*nums)/sum(nums);
% disp(mean_error)

bar(errors)
figFormat(20,'Area No','Error distance (m)')
xlim([0 22])
ylim([0 3]);
savegcf('figures/deeploc/error_bar_0')
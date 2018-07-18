%%
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

resultpath='data_new/result/';
exp_num='deeploc';
areas=1;%[1 2 5];

for area_i=areas
    data=load([resultpath exp_num '/' area_table{area_i} '_soft0_deeploc_testResult.txt']);
    cdfappend(data(:,1));
%     mycdfplot(data(:,1),1,'Error distance','CDF');
end

cdfplots(1,'Error distance','CDF');
legend('DeepLoc','WiMag','RADAR');
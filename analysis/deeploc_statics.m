%%
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

area_i=4;
sub_area_num=12;
exp_num='deeploc';

type=1; 
filename=['.\data_new\result\' exp_num '\' area_table{area_i} '_soft_cdn_predict_evaluate.csv'];
deeploc_static(filename,type,sub_area_num);
savegcf(['data_new/figures/deeploc/' area_table{area_i} 'error_bar_' n2s(type)]);

type=2; 
filename=['.\data_new\result\' exp_num '\' area_table{area_i} '_soft_deeploc_evaluate.txt'];
deeploc_static(filename,type,sub_area_num);
savegcf(['data_new/figures/deeploc/' area_table{area_i} 'error_bar_' n2s(type)]);

% filename=['.\data_new\result\3\cdn_predict_evaluate.csv'];
% deeploc_static(filename,1);
% savegcf('figures/deeploc/error_bar_0')
% filename=['.\data_new\result\3\55-4-W_soft0_deeploc_testResult.txt'];
% deeploc_static(filename,2);
% savegcf('figures/deeploc/error_bar_1')
%%
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load(['data/fingerprints' data_version '.mat']);

area_i=10;
sub_area_num=fps{area_i}.knum;
exp_num='tmp';
data_label='cluster';
type=1;
filename=[deeploc_path '\result\' exp_num '\' area_table{area_i} data_label '_cdn_predict_evaluate.csv'];
[nums,errors]=deeploc_static(filename,type,sub_area_num);
savegcf(['data_new/figures/deeploc/' area_table{area_i} 'error_bar_' n2s(type)]);
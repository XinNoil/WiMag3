% pre
% Date:     2018/08/22
% Auther:   WJK
% Function: This is a script for preparing the environment.
%           该脚本用于准备环境。
% Contact:  jiankunwang@tju.edu.cn

%% add paths
work_path = pwd;
addpath('./process');
addpath('./setting files');
addpath(genpath('./tools'));
%% save glo.mat
if exist('./setting files/glo.mat','file')
    save('./setting files/glo.mat','-append','work_path')
    disp(['update work_path:' work_path]);
else
    save('./setting files/glo.mat','work_path')
    disp('warning: glo.mat not found!');
end
%% load glo.mat
load glo.mat
disp(['data_version:' data_version]);
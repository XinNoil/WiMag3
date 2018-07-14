% Date:     2017/12/12
% Auther:   WJK
% Function: This Script construct area settings
%           这个脚本用于创建区域的设置
% Contact:  jiankunwang@tju.edu.cn
% Note:     参考点集由三个meshgrid组合

clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
for i=1:length(area_table)
    if ~exist(['data/' area_table{i}],'dir')
        mkdir(['data/' area_table{i}]);
    end
end
% 区域设置
i_area=10;
% 存储设置
s.data_version=data_version;
s.is_new_fingerprint=true; %是否保存fingerpint
s.is_save_fingerprint=true; %是否保存fingerpint
s.is_plot_magnetic_object=false; % 是否画出磁性物体
s.is_savegcf=true;
% 执行区域配置程序
if i_area>0
    settings=config_area(i_area);
    save_fingerprint(i_area,settings,s)
else
    for i=1:length(area_table)
        settings=config_area(i);
        save_fingerprint(i,settings,s)
    end
end

% load (['data/fingerprints' s.data_version '.mat']);
% load(['data/' area_table{i_area} '/testdata' s.data_version '.mat']);
% fp=fps{i_area};
% fpcdns=fp.cdns;
% tdcdns=td.cdns;
% save data/tmp.mat fpcdns tdcdns fp td
% setupdatefun(@myupdatefcn3);
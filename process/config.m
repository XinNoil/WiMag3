% Date:     2017/12/12
% Auther:   WJK
% Function: This script construct area settings.
%           这个脚本用于创建区域的设置。
% Note:     
% 
% # ITEM1   After excute this script, ,run scan_bssids.m to genrate bssid_map
%           run 'process_origin.m' to process origin data and generate 
%           fingerprintsn.mat.
%           执行完这个脚本后，需要执行scan_bssids.m，生成bssid_map
%           执行process_origin.m处理原始数据，生成fingerprintsn.mat文件。
%           
% # ITEM2   参考点和测试点集合由多个gridmesh组成。
% Contact:  jiankunwang@tju.edu.cn

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
i_area=2;
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
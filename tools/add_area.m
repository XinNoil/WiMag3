function add_area(name,rssi,fp_freq,td_freq)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for adding a new area to the area_table.
%           该函数用于向区域列表中添加一个新区域。
% Contact:  jiankunwang@tju.edu.cn
load glo.mat;
cd (work_path)
area_table{end+1}=name;
mkdir(['data/' area_table{end}]);
mkdir(['figures/' area_table{end}]);
mkdir(['result/' area_table{end}]);
is_rssi(end+1)=rssi;
fps_rssi_freq(end+1)=fp_freq;
tds_rssi_freq(end+1)=td_freq;
disp(['area' n2s(length(area_table)) ':' name]);
disp(['is_rssi: ' n2s(is_rssi(end))]);
disp(['rssi fingerprint sample rate: ' n2s(fps_rssi_freq(end))]);
disp(['rssi testdata sample rate: ' n2s(tds_rssi_freq(end))]);
save('glo.mat','-append','area_table','is_rssi','fps_rssi_freq','tds_rssi_freq');
load('glo.mat');

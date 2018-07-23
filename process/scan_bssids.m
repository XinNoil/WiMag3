% Date:     2017/12/12
% Auther:   WJK
% Function: This Script select access points
%           ����ű�����ɸѡAP
% Note:     ɨ��bssid������bssid_map
% Contact:  jiankunwang@tju.edu.cn


clear
clc
load glo.mat
cd (work_path)
% ��������
i_area=14;
disp(['data_version:' data_version]);
RSSI_threshold=-80;
if i_area>0
    scan_bssid(i_area,RSSI_threshold);
else
    i_areas=1:length(area_table);
    i_areas=i_areas(is_rssi);
    for i_area=i_areas
        scan_bssid(i_area,RSSI_threshold);
    end
end
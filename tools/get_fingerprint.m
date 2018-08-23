function [i_area,settings,area_size,bssid_map]=get_fingerprint(fp)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for initialing a database.
%           �ú������ڳ�ʼ��һ�����ݿ⡣
% Contact:  jiankunwang@tju.edu.cn
i_area=fp.i_area;
settings=fp.settings;
area_size=fp.area_size;
if isfield(fp,'bssid_map')
    bssid_map=fp.bssid_map;
else
    bssid_map={};
end
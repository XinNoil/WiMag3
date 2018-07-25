% Date:     2017/12/12
% Auther:   WJK
% Function: This script construct area settings.
%           ����ű����ڴ�����������á�
% Note:     
% 
% # ITEM1   After excute this script, ,run scan_bssids.m to genrate bssid_map
%           run 'process_origin.m' to process origin data and generate 
%           fingerprintsn.mat.
%           ִ��������ű�����Ҫִ��scan_bssids.m������bssid_map
%           ִ��process_origin.m����ԭʼ���ݣ�����fingerprintsn.mat�ļ���
%           
% # ITEM2   �ο���Ͳ��Ե㼯���ɶ��gridmesh��ɡ�
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
% ��������
i_area=2;
% �洢����
s.data_version=data_version;
s.is_new_fingerprint=true; %�Ƿ񱣴�fingerpint
s.is_save_fingerprint=true; %�Ƿ񱣴�fingerpint
s.is_plot_magnetic_object=false; % �Ƿ񻭳���������
s.is_savegcf=true;
% ִ���������ó���
if i_area>0
    settings=config_area(i_area);
    save_fingerprint(i_area,settings,s)
else
    for i=1:length(area_table)
        settings=config_area(i);
        save_fingerprint(i,settings,s)
    end
end
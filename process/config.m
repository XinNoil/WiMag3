% config
% Date:     2018/8/22
% Auther:   WJK
% Function: This script construct area settings.
%           ����ű����ڴ�����������á�
% Note:     
% 
% # ITEM1   �ο���Ͳ��Ե㼯���ɶ��gridmesh��ɡ�
% Contact:  jiankunwang@tju.edu.cn

my_head
for i=1:length(area_table)
    if ~exist(['data/' area_table{i}],'dir')
        mkdir(['data/' area_table{i}]);
    end
end
% area number ('0' means all area)
i_area=4;
% settings
s.data_version=data_version;
s.is_new_fingerprint=true; %�Ƿ񱣴�fingerpint
s.is_save_fingerprint=true; %�Ƿ񱣴�fingerpint
s.is_plot_magnetic_object=false; % �Ƿ񻭳���������
s.is_savegcf=true;
% excute
if i_area>0
    settings=config_area(i_area);
    save_fingerprint(i_area,settings,s)
else
    for i=1:length(area_table)
        settings=config_area(i);
        save_fingerprint(i,settings,s)
    end
end
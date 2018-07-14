% Date:     2017/12/12
% Auther:   WJK
% Function: This Script construct area settings
%           ����ű����ڴ������������
% Contact:  jiankunwang@tju.edu.cn
% Note:     �ο��㼯������meshgrid���

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
i_area=10;
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

% load (['data/fingerprints' s.data_version '.mat']);
% load(['data/' area_table{i_area} '/testdata' s.data_version '.mat']);
% fp=fps{i_area};
% fpcdns=fp.cdns;
% tdcdns=td.cdns;
% save data/tmp.mat fpcdns tdcdns fp td
% setupdatefun(@myupdatefcn3);
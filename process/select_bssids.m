% Date:     2017/12/12
% Auther:   WJK
% Function: This Script select access points
%           ����ű�����ɸѡAP
% Contact:  jiankunwang@tju.edu.cn
% Note:     ����bssid_map

clear
clc
load glo.mat
cd (work_path)
% ��������
i_area=9;
disp(['data_version:' data_version]);
RSSI_threshold=-80;
if i_area>0
    load(['data/' area_table{i_area} '/fingerprint' data_version '.mat']);
    settings=fp.settings;
    % BSSID_MAP����
    bssids=[];
    rssis={};
    for i=1:length(settings)
        cd (['original_data/' area_table{i_area} '/long/' num2str(i)])
        gridmesh=settings{i}.gridmesh;
        for j=1:length(gridmesh)
            if strcmp(gridmesh(j).type,'0')
                tmp_bssids=select_gridmesh(gridmesh(j),RSSI_threshold);
                bssids=unique([bssids;tmp_bssids]);
            end
        end
        cd ../../../..
    end

    bssid_map=containers.Map(bssids,num2cell(1:length(bssids)));
    fp.bssid_map=bssid_map;
    save(['data/' area_table{i_area} '/fingerprint' data_version '.mat'],'fp');
    disp(bssid_map);
else
    i_areas=1:length(area_table);
    i_areas=i_areas(is_rssi);
    for i_area=i_areas
        load(['data/' area_table{i_area} '/fingerprint' data_version '.mat']);
        settings=fp.settings;
        % BSSID_MAP����
        bssids=[];
        for i=1:length(settings)
            cd (['original_data/' area_table{i_area} '/long/' num2str(i)])
            gridmesh=settings{i}.gridmesh;
            for j=1:length(gridmesh)
                if strcmp(gridmesh(j).type,'0')
                    tmp_bssids=select_gridmesh(gridmesh(j),RSSI_threshold);
                    bssids=unique([bssids;tmp_bssids]);
                end
            end
            cd ../../../..
        end

        bssid_map=containers.Map(bssids,num2cell(1:length(bssids)));
        fp.bssid_map=bssid_map;
        save(['data/' area_table{i_area} '/fingerprint' data_version '.mat'],'fp');
        disp(bssid_map);
    end
end
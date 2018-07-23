% Date:     2018/07/14
% Auther:   WJK
% Function: Process original data of magnetism-based indoor localization.
%           处理基于地磁室内定位的原始数据
% Contact:  jiankunwang@tju.edu.cn

clear
clc
load glo.mat
cd (work_path)
% 参数设置
disp(['data_version:' data_version]);
disp(' ');
i_areas=14%1:length(area_table);
outdoor_magnetics=[28.5 -43.6];
head=false; %是否删除首
tail=false; %是否删除尾
RSSI_threshold=-80;
check_file_mode=false;

% 存储设置
is_save_fingerprint=true; %是否保存fingerpint
is_save_testdata=true; %是否保存testdata
is_save_database=true; %是否保存databas
mag_cols=18:20;
for i_area=i_areas
    diary_filename=['setting files/process_origin/' area_table{i_area} '.txt'];
    diaryon;
    disp(['data_version:' data_version]);
    clear fp td db;
    is_have_fingerprint=false;
    is_have_testdata=false;
    load(['data/' area_table{i_area} '/fingerprint' data_version '.mat']);
    if (is_rssi(i_area)&&~isfield(fp,'bssid_map'))
        scan_bssid(i_area,RSSI_threshold);
        load(['data/' area_table{i_area} '/fingerprint' data_version '.mat']);
    end
    [~,settings,area_size,bssid_map]=get_fingerprint(fp);
%     plot_floor_mark(settings);
    td.i_area=i_area;
    db.i_area=i_area;
    fp=init_database( fp,is_rssi(i_area) );
    td=init_database( td,is_rssi(i_area) );
    db=init_database( db,is_rssi(i_area) );
    disp(['区域:' area_table{i_area}])
    disp(['总面积:' num2str(area_size)]);
    disp(' ');
    for i_subarea=1:length(settings)
        setting=settings{i_subarea};
        [block_size,origin,M,N,gridmesh]=get_setting(setting);
        disp(['子区域:' num2str(i_subarea)])
        disp(['面积:' num2str(setting.area_size)])
        for i=1:length(gridmesh)
            gridmesh(i).i_area=i_area;
            gridmesh(i).i_subarea=i_subarea;
            gridmesh(i).is_rssi=is_rssi(i_area);
            results=process_gridmesh(gridmesh(i),is_rssi(i_area),mag_cols,bssid_map,setting.origin,head,tail,check_file_mode);
            switch gridmesh(i).type
                case '0'
                    is_have_fingerprint=true;
                    fp=append_results(fp,results);
                case '1'
                    is_have_testdata=true;
                    td=append_results(td,results);
            end
            db=append_results(db,results);
        end
        disp(' ');
    end
    if is_have_fingerprint&&is_save_fingerprint
        fp=before_save(fp,outdoor_magnetics);
        save(['data/' area_table{i_area} '/fingerprint' data_version '.mat'],'fp');
    end
    if is_have_testdata&&is_save_testdata
        td.bssid_map=bssid_map;
        td=before_save(td,outdoor_magnetics);
        save(['data/' area_table{i_area} '/testdata' data_version '.mat'],'td');
    end
    if is_save_database
        db.bssid_map=bssid_map;
        db=before_save(db,outdoor_magnetics);
        save(['data/' area_table{i_area} '/database' data_version '.mat'],'db');
    end
    diary off;
end
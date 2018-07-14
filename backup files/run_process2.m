% Date:     2017/11/06
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
i_areas=1:length(area_table);
outdoor_magnetics=[28.5 -43.6];
head=false; %是否删除首
tail=false; %是否删除尾
% 存储设置
is_save_fingerprint=false; %是否保存fingerpint
is_save_testdata=false; %是否保存testdata
is_save_database=false; %是否保存databas
mag_cols=18:20;
for i_area=4 %i_areas
    clear fp td db;
    is_have_fingerprint=false;
    is_have_testdata=false;
    load(['data/' area_table{i_area} '/fingerprint' data_version '.mat']);
    [~,settings,area_size,bssid_map]=get_fingerprint(fp);
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
            results=process_gridmesh(gridmesh(i),is_rssi(i_area),mag_cols,bssid_map,setting.origin,head,tail);
            switch gridmesh(i).type
                case '0'
                    is_have_fingerprint=true;
                    fp=append_results(fp,is_rssi(i_area),results);
                case '1'
                    is_have_testdata=true;
                    td=append_results(td,is_rssi(i_area),results);
            end
            db=append_results(db,is_rssi(i_area),results);
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
end
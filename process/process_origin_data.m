% process_origin_data
% Date:     2018/07/14
% Auther:   WJK
% Function: Process original data of magnetism-based indoor localization.
%           ������ڵش����ڶ�λ��ԭʼ����
% Contact:  jiankunwang@tju.edu.cn

my_head;
i_areas=[1 2 4 5 9 10 11 14 15];%1:length(area_table);
outdoor_magnetics=[28.5 -43.6];
head=false; %�Ƿ�ɾ����
tail=false; %�Ƿ�ɾ��β
RSSI_threshold=-80;
check_file_mode=false;

% �洢����
is_save_fingerprint=true&~check_file_mode; %�Ƿ񱣴�fingerpint
is_save_testdata=true&~check_file_mode; %�Ƿ񱣴�testdata
is_save_database=true&~check_file_mode; %�Ƿ񱣴�databas
for i_area=i_areas
    diary_filename=['setting files/process_origin/' area_table{i_area} '.txt'];
    diaryon;
    disp(['data_version:' data_version]);
    clear fp td db;
    is_have_fingerprint=false;
    is_have_testdata=false;
    load(['data/' area_table{i_area} '/fingerprint' data_version '.mat']);
    if ~exist(['original_data/' area_table{i_area}],'file')
        disp(['original_data/' area_table{i_area}  ':not found']);
        continue;
    end
    if is_rssi(i_area)%% &&~isfield(fp,'bssid_map'))
        if exist(['original_data/' area_table{i_area} '/long/'],'file')
            bssids=findAllAPFromPath(['original_data/' area_table{i_area} '/long/'], RSSI_threshold);
            bssid_map=containers.Map(bssids,num2cell(1:length(bssids)));
            fp.bssid_map=bssid_map;
            disp(bssid_map);
            save(['data/' area_table{i_area} '/fingerprint' data_version '.mat'],'fp');
            disp(['save to: data/' area_table{i_area} '/fingerprint' data_version '.mat']);
            load(['data/' area_table{i_area} '/fingerprint' data_version '.mat']);
        else
            disp(['original_data/' area_table{i_area} '/long :not found']);
        end
    end
    [~,settings,area_size,bssid_map]=get_fingerprint(fp);
    td.i_area=i_area;
    db.i_area=i_area;
    fp=init_database(fp,is_rssi(i_area));
    td=init_database(td,is_rssi(i_area));
    db=init_database(db,is_rssi(i_area));
    disp(['����:' area_table{i_area}])
    disp(['�����:' num2str(area_size)]);
    disp(' ');
    for i_subarea=1:length(settings)
        setting=settings{i_subarea};
        [block_size,origin,M,N,gridmesh]=get_setting(setting);
        disp(['������:' num2str(i_subarea)])
        disp(['���:' num2str(setting.area_size)])
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
    if is_have_testdata&&is_save_testdata
        td.bssid_map=bssid_map;
        td=before_save(td,outdoor_magnetics);
        save(['data/' area_table{i_area} '/testdata' data_version '.mat'],'td');
        fp=set_rssi_mask(fp,td,is_rssi(i_area));
    end
    if is_have_fingerprint&&is_save_fingerprint
        fp=before_save(fp,outdoor_magnetics);
        save(['data/' area_table{i_area} '/fingerprint' data_version '.mat'],'fp');
    end
    if is_save_database
        db.bssid_map=bssid_map;
        db=before_save(db,outdoor_magnetics);
        save(['data/' area_table{i_area} '/database' data_version '.mat'],'db');
    end
    diary off;
end
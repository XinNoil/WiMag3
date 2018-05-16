% Date:     2017/11/06
% Auther:   WJK
% Function: Process original data of magnetism-based indoor localization.
%           ������ڵش����ڶ�λ��ԭʼ����
% Contact:  jiankunwang@tju.edu.cn

clear
clc
load glo.mat
cd (work_path)
% ��������
data_version='1';
i_areas=1:7;
outdoor_magnetics=[28.5 -43.6];
head=false; %�Ƿ�ɾ����
tail=false; %�Ƿ�ɾ��β
% �洢����
is_save_fingerprint=true; %�Ƿ񱣴�fingerpint
is_save_fingerprints=true; %�Ƿ񱣴�fingerpints
is_save_testdata=true; %�Ƿ񱣴�testdata
is_save_database=true; %�Ƿ񱣴�databas
fps=cell(1,length(area_table));
mag_cols=18:20;
for i_area=i_areas %i_areas
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
    fps{i}=fp;
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
if is_have_fingerprint&&is_save_fingerprints
    save(['data/fingerprints' data_version '.mat'],'fps');
end
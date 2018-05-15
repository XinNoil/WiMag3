% Date:     2017/11/06
% Auther:   WJK
% Function: Process original data of magnetism-based indoor localization.
%           �������ڵش����ڶ�λ��ԭʼ����
% Contact:  jiankunwang@tju.edu.cn

clear
clc
load glo.mat
cd (work_path)
% ��������
data_version='1';
% �洢����
is_save_fingerprint=true; %�Ƿ񱣴�fingerpint
is_save_testdata=false; %�Ƿ񱣴�fingerpint
is_save_database=false; %�Ƿ񱣴�fingerpint
is_rssi=[true true false true true true true] ;
head=false;
tail=false;
i_areas=1:7;
i_areas=i_areas(is_rssi);
for i_area=7 %i_areas
    clear fp td db;
    load(['data/' area_table{i_area} '/fingerprint' data_version '.mat']);
    [~,settings,area_size,bssid_map]=get_fingerprint(fp);
    td.i_area=i_area;
    db.i_area=i_area;
    fp=init_database( fp,is_rssi(i_area) );
    td=init_database( td,is_rssi(i_area) );
    db=init_database( db,is_rssi(i_area) );
    for i_subarea=1:length(settings)
        setting=settings{i_subarea};
        [block_size,origin,M,N,gridmesh]=get_setting(setting);
        disp(['����:' num2str(i_subarea)])
        disp(['���:' num2str(setting.area_size)])
        mag_cols=18:20;
        for i=1:length(gridmesh)
            if is_rssi(i_area)
                switch gridmesh(i).type
                    case '0'
                        disp('�ο���...');
%                         paths{1}=get_dpath( area_table,i_area,i_subarea,'short' );
                        paths{1}=get_dpath( area_table,i_area,i_subarea,'long' );
                        paths{2}=get_dpath( area_table,i_area,i_subarea,'long' );
                        [cdns,magnetics,rssis,bssid_maps,bssid_indexs,types]=process_gridmesh_r(paths,gridmesh(i),mag_cols,bssid_map,setting.origin,head,tail);
                        fp = join_gridmesh( fp,cdns,magnetics,rssis,bssid_maps,bssid_indexs,types );
                    case '1'
                        disp('���Ե�...');
                        paths{1}=get_dpath( area_table,i_area,i_subarea,'short' );
                        paths{2}=get_dpath( area_table,i_area,i_subarea,'short' );
                        [cdns,magnetics,rssis,bssid_maps,bssid_indexs,types]=process_gridmesh_t(paths,gridmesh(i),mag_cols,bssid_map,setting.origin,head,tail);
                        td = join_gridmesh( td,cdns,magnetics,rssis,bssid_maps,bssid_indexs,types );
                end
                db = join_gridmesh( db,cdns,magnetics,rssis,bssid_maps,bssid_indexs,types );
            else
                switch gridmesh(i).type
                    case '0'
                        disp('�ο���...');
                        paths{1}=get_dpath( area_table,i_area,i_subarea,'short' );
                        paths{2}=get_dpath( area_table,i_area,i_subarea,'long' );
                        [cdns,magnetics,types]=process_gridmesh_r_m(paths,gridmesh(i),mag_cols,setting.origin);
                        fp = join_gridmesh( fp,cdns,magnetics,types );
                    case '1'
                        disp('���Ե�...');
                        paths{1}=get_dpath( area_table,i_area,i_subarea,'short' );
                        paths{2}=get_dpath( area_table,i_area,i_subarea,'short' );
                        [cdns,magnetics,types]=process_gridmesh_t_m(paths,gridmesh(i),mag_cols,setting.origin);
                        td = join_gridmesh( td,cdns,magnetics,types );
                end
                db = join_gridmesh( db,cdns,magnetics,types );
            end
        end
        disp(' ');
    end
    disp(['�����:' num2str(area_size)]);

    if is_save_fingerprint
        fp.rqs_num=size(fp.cdns,1);
        fp.magnitudes=sqrt(fp.magnetics(:,1).*fp.magnetics(:,1)+fp.magnetics(:,2).*fp.magnetics(:,2));
        save(['data/' area_table{i_area} '/fingerprint' data_version '.mat'],'fp');
    end
    if is_save_testdata
        td.test_num=size(td.cdns,1);
        td.magnitudes=sqrt(td.magnetics(:,1).*td.magnetics(:,1)+td.magnetics(:,2).*td.magnetics(:,2));
        save(['data/' area_table{i_area} '/testdata' data_version '.mat'],'td');
    end
    if is_save_database
        db.num=size(db.cdns,1);
        db.magnitudes=sqrt(db.magnetics(:,1).*db.magnetics(:,1)+db.magnetics(:,2).*db.magnetics(:,2));
        save(['data/' area_table{i_area} '/database' data_version '.mat'],'db');
    end
end
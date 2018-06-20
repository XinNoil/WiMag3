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
% 存储设置
is_save_fingerprint=true; %是否保存fingerpint
is_save_testdata=false; %是否保存fingerpint
is_save_database=true; %是否保存fingerpint
head=true;
tail=true;
i_areas=1:7;
i_areas=i_areas(is_rssi);
for i_area=1:5
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
        disp(['区域:' num2str(i_subarea)])
        disp(['面积:' num2str(setting.area_size)])
        mag_cols=18:20;
        for i=1:length(gridmesh)
            if is_rssi(i_area)
                switch gridmesh(i).type
                    case '0'
                        disp('参考点...');
%                         paths{1}=get_dpath( area_table,i_area,i_subarea,'short' );
                        paths{1}=get_dpath( i_area,i_subarea,'short' );
                        paths{2}=get_dpath( i_area,i_subarea,'long' );
                        [cdns,magnetics,rssis,bssid_maps,bssid_indexs,types]=process_gridmesh_r(paths,gridmesh(i),mag_cols,bssid_map,setting.origin,head,tail);
                        fp = join_gridmesh( fp,cdns,magnetics,rssis,bssid_maps,bssid_indexs,types );
                    case '1'
                        disp('测试点...');
                        paths{1}=get_dpath( i_area,i_subarea,'short' );
                        paths{2}=get_dpath( i_area,i_subarea,'short' );
                        [cdns,magnetics,rssis,bssid_maps,bssid_indexs,types]=process_gridmesh_t(paths,gridmesh(i),mag_cols,bssid_map,setting.origin,head,tail);
                        td = join_gridmesh( td,cdns,magnetics,rssis,bssid_maps,bssid_indexs,types );
                end
                db = join_gridmesh( db,cdns,magnetics,rssis,bssid_maps,bssid_indexs,types );
            else
                switch gridmesh(i).type
                    case '0'
                        disp('参考点...');
                        paths{1}=get_dpath( i_area,i_subarea,'short' );
                        [cdns,magnetics,types]=process_gridmesh_r_m(paths,gridmesh(i),mag_cols,setting.origin);
                        fp = join_gridmesh( fp,cdns,magnetics,types );
                    case '1'
                        disp('测试点...');
                        paths{1}=get_dpath( i_area,i_subarea,'short' );
                        [cdns,magnetics,types]=process_gridmesh_t_m(paths,gridmesh(i),mag_cols,setting.origin);
                        td = join_gridmesh( td,cdns,magnetics,types );
                end
                db = join_gridmesh( db,cdns,magnetics,types );
            end
        end
        disp(' ');
    end
    disp(['总面积:' num2str(area_size)]);

    if is_save_fingerprint
        fp.num=size(fp.cdns,1);
        fp.magnitudes=sqrt(fp.magnetics(:,1).*fp.magnetics(:,1)+fp.magnetics(:,2).*fp.magnetics(:,2));
        save(['data/' area_table{i_area} '/fingerprint' data_version '.mat'],'fp');
    end
    if is_save_testdata
        td.num=size(td.cdns,1);
        td.magnitudes=sqrt(td.magnetics(:,1).*td.magnetics(:,1)+td.magnetics(:,2).*td.magnetics(:,2));
        save(['data/' area_table{i_area} '/testdata' data_version '.mat'],'td');
    end
    if is_save_database
        db.num=size(db.cdns,1);
        db.magnitudes=sqrt(db.magnetics(:,1).*db.magnetics(:,1)+db.magnetics(:,2).*db.magnetics(:,2));
        save(['data/' area_table{i_area} '/database' data_version '.mat'],'db');
    end
end

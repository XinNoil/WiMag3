clear
clc
load glo.mat
cd (work_path)

i_areas=1:7;
data_type='rssi'; %rssi/mag
if strcmp(data_type,'rssi')
    i_areas=i_areas(is_rssi);
end
for i_area=i_areas
    load(['data/' area_table{i_area} '/fingerprint' data_version '.mat']);
    [~,settings,~,bssid_map]=get_fingerprint(fp);
    for i_subarea=1:length(settings)
        setting=settings{i_subarea};
        [~,origin,~,~,gridmesh]=get_setting(setting);
        for i=1:length(gridmesh)
            switch gridmesh(i).type
                case '0' % ≤Œøºµ„
                    sub_dir='long';
                case '1' % ≤‚ ‘µ„
                    sub_dir='short';                    
            end
            path=get_dpath(area_table,i_area,i_subarea,sub_dir);
            analysis_gridmesh_time_series(path,data_type);
        end
    end
end
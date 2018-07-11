clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

% 参数设置
areas=[1 2 4 5];
sub_grid_size=5.001; % 子区域大小
mag_cols=18:20;
test_time=2;
save_path='data_new/DeepLoc/';

% 载入数据
load (['data/fingerprints' data_version '.mat']);
load (['data/testdatas' data_version '.mat']);

for i=1%:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    categorical_vector_m=[];
    cdns_m=[];
    rssis_m=[];
    magnetics_m=[];
    for r=1:10%fp.num
        tmp_cdn=fp.cdns(r,:);
        [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(fp.wfiles{r},fp.bssid_map);
        tmp_magnetics=process_magnetic(fp.sfiles{r},RecordsNum,mag_cols,test_time);
        categorical_vector_m=[categorical_vector_m ; repmat(fp.categorical_vector(r,:),RecordsNum,1)];
        cdns_m=[cdns_m ; repmat( tmp_cdn , RecordsNum , 1 )];
        magnetics_m=[magnetics_m ; tmp_magnetics];
        rssis_m=[rssis_m ; tmp_rssi];
    end
    [mag_max,mag_min]=get_magnetic_statics(area_i);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    cdns_m=cdns_m-cdn_min;
    magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
    rssis_m=(rssis_m+100)/70;
    rssis_m(rssis_m<0)=0;
    rssis_m(rssis_m>1)=1;
    m=[categorical_vector_m cdns_m magnetics_m rssis_m];
    disp([save_path area_table{area_i} '_soft0_training.csv']);
    csvwrite([save_path area_table{area_i} '_soft0_training.csv'],m);
end

for i=1%:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    td=tds{area_i};
    td.categorical_vector=get_subarea_soft(fp.area_vertexs,td.cdns);
    categorical_vector_m=[];
    cdns_m=[];
    rssis_m=[];
    magnetics_m=[];
    for t=1:td.num
        tmp_cdn=td.cdns(t,:);
        [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(td.wfiles{t},fp.bssid_map);
        tmp_magnetics=process_magnetic(td.sfiles{t},RecordsNum,mag_cols,test_time);
        categorical_vector_m=[categorical_vector_m ; repmat(td.categorical_vector(t,:),RecordsNum,1)];
        cdns_m=[cdns_m ; repmat( tmp_cdn , RecordsNum , 1 )];
        magnetics_m=[magnetics_m ; tmp_magnetics];
        rssis_m=[rssis_m ; tmp_rssi];
    end
    [mag_max,mag_min]=get_magnetic_statics(area_i);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    cdns_m=cdns_m-cdn_min;
    magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
    rssis_m=(rssis_m+100)/70;
    rssis_m(rssis_m<0)=0;
    rssis_m(rssis_m>1)=1;
    m=[categorical_vector_m cdns_m magnetics_m rssis_m];
    disp([save_path area_table{area_i} '_soft0_testing.csv']);
    csvwrite([save_path area_table{area_i} '_soft0_testing.csv'],m);
end

% cdn predict train
for i=1%:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    area_code_num=size(fp.categorical_vector,2);
    for area_code=1:area_code_num
        area_mask=fp.categorical_vector(:,area_code)>0;
        cdns_m=[];
        rssis_m=[];
        magnetics_m=[];
        
        subfp.i_area=fp.i_area;
        subfp.sub_i=area_code;
        subfp.bssid_map=fp.bssid_map;
        subfp.cdns_m=[];
        subfp.rssis_m=[];
        subfp.magnetics_m=[];
        subfp.cdns=fp.cdns(area_mask,:);
        subfp.rssis=fp.rssis(area_mask,:);
        subfp.magnetics=fp.magnetics(area_mask,:);
        subfp.wfiles=fp.wfiles(area_mask);
        subfp.sfiles=fp.sfiles(area_mask);
        for p=1:size(subfp.cdns,1)
            tmp_cdn=subfp.cdns(p,:);
            [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(subfp.wfiles{p},subfp.bssid_map);
            tmp_magnetics=process_magnetic(subfp.sfiles{p},RecordsNum,mag_cols,test_time);
            cdns_m=[cdns_m ; repmat( tmp_cdn , RecordsNum , 1 )];
            magnetics_m=[magnetics_m ; tmp_magnetics];
            rssis_m=[rssis_m ; tmp_rssi];
        end
        subfp.cdns_m=[subfp.cdns_m ; repmat( tmp_cdn , RecordsNum , 1 )];
        subfp.magnetics_m=[subfp.magnetics_m ; tmp_magnetics];
        subfp.rssis_m=[subfp.rssis_m ; tmp_rssi];
        [mag_max,mag_min]=get_magnetic_statics(area_i);
        [cdn_max,cdn_min]=get_cdns_statics(area_i);
        cdns_m=cdns_m-cdn_min;
        magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
        rssis_m=(rssis_m+100)/70;
        rssis_m(rssis_m<0)=0;
        rssis_m(rssis_m>1)=1;
        m=[repmat(area_code,size(cdns_m,1),1) cdns_m magnetics_m rssis_m];
        disp([save_path area_table{area_i} '_soft' n2s(area_code) '_training.csv']);
        csvwrite([save_path area_table{area_i} '_soft' n2s(area_code) '_training.csv'],m);
    end
end

% cdn predict test
for i=1%:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    td=tds{area_i};
    td.categorical_vector=get_subarea_soft(fp.area_vertexs,td.cdns);
    area_code_num=size(fp.categorical_vector,2);
    for area_code=1:area_code_num
        area_mask=td.categorical_vector(:,area_code)>0;
        cdns_m=[];
        rssis_m=[];
        magnetics_m=[];
        
        subtd.i_area=td.i_area;
        subtd.sub_i=area_code;
        subtd.bssid_map=td.bssid_map;
        subtd.cdns_m=[];
        subtd.rssis_m=[];
        subtd.magnetics_m=[];
        subtd.cdns=td.cdns(area_mask,:);
        subtd.rssis=td.rssis(area_mask,:);
        subtd.magnetics=td.magnetics(area_mask,:);
        subtd.wfiles=td.wfiles(area_mask);
        subtd.sfiles=td.sfiles(area_mask);
        for p=1:size(subtd.cdns,1)
            tmp_cdn=subtd.cdns(p,:);
            [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(subtd.wfiles{p},subtd.bssid_map);
            tmp_magnetics=process_magnetic(subtd.sfiles{p},RecordsNum,mag_cols,test_time);
            cdns_m=[cdns_m ; repmat( tmp_cdn , RecordsNum , 1 )];
            magnetics_m=[magnetics_m ; tmp_magnetics];
            rssis_m=[rssis_m ; tmp_rssi];
        end
        subtd.cdns_m=[subtd.cdns_m ; repmat( tmp_cdn , RecordsNum , 1 )];
        subtd.magnetics_m=[subtd.magnetics_m ; tmp_magnetics];
        subtd.rssis_m=[subtd.rssis_m ; tmp_rssi];
        [mag_max,mag_min]=get_magnetic_statics(area_i);
        [cdn_max,cdn_min]=get_cdns_statics(area_i);
        cdns_m=cdns_m-cdn_min;
        magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
        rssis_m=(rssis_m+100)/70;
        rssis_m(rssis_m<0)=0;
        rssis_m(rssis_m>1)=1;
        m=[repmat(area_code,size(cdns_m,1),1) cdns_m magnetics_m rssis_m];
        disp([save_path area_table{area_i} '_soft' n2s(area_code) '_testing.csv']);
        csvwrite([save_path area_table{area_i} '_soft' n2s(area_code) '_testing.csv'],m);
    end
end
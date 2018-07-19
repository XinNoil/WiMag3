%%
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

% 参数设置
areas=[1 10];%[1 2 4 5 10 11];
mag_cols=18:20;
test_time=1;
data_ver='0';
save_path=[deeploc_path '\data\' data_ver '\'];
is_average=false;
magnetic_dim=2;
label_type='cluster';
if ~exist(save_path,'dir')
    mkdir (save_path);
end
ver_label='cluster';

% 载入数据
load (['data/fingerprints' data_version '.mat']);
load (['data/testdatas' data_version '.mat']);

% remove_no=[75 145 215 216];
% remove_no=[1,27,50,165,299,357,102,369];
remove_no=[];
%% area predict train
for i=1:length(areas)
    area_i=areas(i);
    data_description.class_num=fps{area_i}.knum;
    data_description.label_type=label_type;
    data_description.magnetic_dim=magnetic_dim;
    data_description.rssi_dim=length(fps{area_i}.bssid_map);
    data_description.rssi_mask=fps{area_i}.k_rssi_mask;
    save_json([save_path area_table{area_i} ver_label '_data_description.json'],data_description);
end

%% training data
for i=1:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    kclass_m=[];
    cdns_m=[];
    rssis_m=[];
    magnetics_m=[];
    for r=1:fp.num
        tmp_cdn=fp.cdns(r,:);
        [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(fp.wfiles{r},fp.bssid_map,'0',fps_rssi_freq(area_i),test_time);
        tmp_magnetics=process_magnetic(fp.sfiles{r},RecordsNum,mag_cols,test_time);
        if is_average
            kclass_m=[kclass_m ; fp.kclass(r)];
            export_data_append_average;
        else
            kclass_m=[kclass_m ; repmat(fp.kclass(r),RecordsNum,1)];
            export_data_append;
        end
    end
    [mag_max,mag_min]=get_magnetic_statics(area_i,magnetic_dim);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    cdns_m=cdns_m-cdn_min;
    magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
    rssis_m=(rssis_m+100)/70;
    rssis_m(rssis_m<0)=0;
    rssis_m(rssis_m>1)=1;
    m=[kclass_m cdns_m magnetics_m rssis_m];
    disp([save_path area_table{area_i} ver_label '0_training.csv']);
    csvwrite([save_path area_table{area_i} ver_label '0_training.csv'],m);
    for k=1:fp.knum
        mask=kclass_m==k;
        mm=m(mask,:);
        disp([save_path area_table{area_i} ver_label n2s(k) '_training.csv']);
        csvwrite([save_path area_table{area_i} ver_label n2s(k) '_training.csv'],mm);
    end
end

%% testing data
for i=1:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    td=tds{area_i};
    kclass_m=[];
    cdns_m=[];
    rssis_m=[];
    magnetics_m=[];
    td_no=1:td.num;
    td_no(remove_no)=[];
    for t=td_no
        tmp_cdn=td.cdns(t,:);
        [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(td.wfiles{t},fp.bssid_map,'1',tds_rssi_freq(area_i),test_time);
        tmp_magnetics=process_magnetic(td.sfiles{t},RecordsNum,mag_cols,test_time);
        if is_average
            kclass_m=[kclass_m ;  fp.kclass];
            export_data_append_average;
        else
            kclass_m=[kclass_m ; repmat(td.kclass(t),RecordsNum,1)];
            export_data_append;
        end
    end
    [mag_max,mag_min]=get_magnetic_statics(area_i,magnetic_dim);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    cdns_m=cdns_m-cdn_min;
    magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
    rssis_m=(rssis_m+100)/70;
    rssis_m(rssis_m<0)=0;
    rssis_m(rssis_m>1)=1;
    m=[kclass_m cdns_m magnetics_m rssis_m];
    disp([save_path area_table{area_i} ver_label '0_testing.csv']);
    csvwrite([save_path area_table{area_i} ver_label '0_testing.csv'],m);
    for k=1:fp.knum
        mask=kclass_m==k;
        mm=m(mask,:);
        disp([save_path area_table{area_i} ver_label n2s(k) '_testing.csv']);
        csvwrite([save_path area_table{area_i} ver_label n2s(k) '_testing.csv'],mm);
    end
end

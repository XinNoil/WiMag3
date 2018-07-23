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
label_type='deeploc';
magnetic_dim=2;
max_rssi=-20;
min_rssi=-100;
if ~exist(save_path,'dir')
    mkdir (save_path);
end

% 载入数据
load (['data/fingerprints' data_version '.mat']);
load (['data/testdatas' data_version '.mat']);

% remove_no=[75 145 215 216];
% remove_no=[1,27,50,165,299,357,102,369];
remove_no=[];
%% area predict train
for i=1:length(areas)
    area_i=areas(i);
    data_description.label_type=label_type;
    data_description.magnetic_dim=magnetic_dim;
    data_description.rssi_dim=length(fps{area_i}.bssid_map);
    save_json([save_path area_table{area_i} '_' label_type '_data_description.json'],data_description);
end
%% pre_training data
data_type='pre_training';
for i=1:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    rssis_input=[];
    rssis_label=[];
    for r=1:fp.num
        [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(fp.wfiles{r},fp.bssid_map,'0',fps_rssi_freq(area_i),test_time);
        rssis_input=[rssis_input ; tmp_rssi];
        rssis_label=[rssis_label ; repmat(mean(tmp_rssi),RecordsNum,1)];
    end
    rssis_input=(rssis_input-min_rssi)/(max_rssi-min_rssi);
    rssis_input(rssis_input<0)=0;
    rssis_input(rssis_input>1)=1;
    rssis_label=(rssis_label-min_rssi)/(max_rssi-min_rssi);
    rssis_label(rssis_label<0)=0;
    rssis_label(rssis_label>1)=1;
    m=[rssis_label rssis_input];
    disp([save_path area_table{area_i} '_' label_type '0_' data_type '.csv']);
    csvwrite([save_path area_table{area_i} '_' label_type '0_' data_type '.csv'],m);
end
%% training data
data_type='training';
for i=1:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    area_im=[];
    cdns_m=[];
    rssis_m=[];
    magnetics_m=[];
    for r=1:fp.num
        tmp_cdn=fp.cdns(r,:);
        [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(fp.wfiles{r},fp.bssid_map,'0',fps_rssi_freq(area_i),test_time);
        tmp_magnetics=process_magnetic(fp.sfiles{r},RecordsNum,mag_cols,test_time);
        area_im=[area_im ; repmat(area_i,RecordsNum,1)];
        export_data_append;
    end
    [mag_max,mag_min]=get_magnetic_statics(area_i,magnetic_dim);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    cdns_m=cdns_m-cdn_min;
    magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
    rssis_m=(rssis_m-min_rssi)/(max_rssi-min_rssi);
    rssis_m(rssis_m<0)=0;
    rssis_m(rssis_m>1)=1;
    m=[area_im cdns_m magnetics_m rssis_m];
    disp([save_path area_table{area_i} '_' label_type '0_' data_type '.csv']);
    csvwrite([save_path area_table{area_i} '_' label_type '0_' data_type '.csv'],m);
end
%% testing data
data_type='testing';
for i=1:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    td=tds{area_i};
    area_im=[];
    cdns_m=[];
    rssis_m=[];
    magnetics_m=[];
    td_no=1:td.num;
    td_no(remove_no)=[];
    for t=td_no
        tmp_cdn=td.cdns(t,:);
        [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(td.wfiles{t},fp.bssid_map,'1',tds_rssi_freq(area_i),test_time);
        tmp_magnetics=process_magnetic(td.sfiles{t},RecordsNum,mag_cols,test_time);
        area_im=[area_im ; repmat(area_i,RecordsNum,1)];
        export_data_append;
    end
    [mag_max,mag_min]=get_magnetic_statics(area_i,magnetic_dim);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    cdns_m=cdns_m-cdn_min;
    magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
    rssis_m=(rssis_m-min_rssi)/(max_rssi-min_rssi);
    rssis_m(rssis_m<0)=0;
    rssis_m(rssis_m>1)=1;
    m=[area_im cdns_m magnetics_m rssis_m];
    disp([save_path area_table{area_i} '_' label_type '0_' data_type '.csv']);
    csvwrite([save_path area_table{area_i} '_' label_type '0_' data_type '.csv'],m);
end

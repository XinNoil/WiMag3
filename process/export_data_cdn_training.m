%%
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

% 参数设置
areas=[15];%[1 2 4 5 10 11 14 15];
mag_cols=18:20;
test_time=1;
data_ver='0';
save_path=[deeploc_path '\data\' data_ver '\'];
magnetic_dim=2;
max_rssi=-20;
min_rssi=-100;
is_average=false;
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
    data_description.magnetic_dim=magnetic_dim;
    data_description.rssi_dim=fps{area_i}.rssi_mask_num;
    save_json([save_path area_table{area_i}  '_data_description.json'],data_description);
end

%% training data
data_type='training';
for i=1:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    cdns_m=[];
    rssis_m=[];
    magnetics_m=[];
    for r=1:fp.num
        tmp_cdn=fp.cdns(r,:);
        rssi_mask=get_rssi_mask(fp);
        [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(fp.wfiles{r},fp.bssid_map,'0',fps_rssi_freq(area_i),test_time,rssi_mask);
        tmp_magnetics=process_magnetic(fp.sfiles{r},RecordsNum,mag_cols,test_time);
        export_data_append;
    end
    [mag_max,mag_min]=get_magnetic_statics(area_i,magnetic_dim);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    cdns_m=cdns_m-cdn_min;
    magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
    rssis_m=my_norm(rssis_m,max_rssi,min_rssi);
    m=[cdns_m magnetics_m rssis_m];
    disp([save_path area_table{area_i}  '_' data_type '.csv']);
    csvwrite([save_path area_table{area_i}  '_' data_type '.csv'],m);
end

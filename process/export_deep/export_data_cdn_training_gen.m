clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

% 参数设置
mag_cols=18:20;
areas=15;
origin_time=15*60-2;
data_ver='1';
save_path=[deeploc_path '\data\' data_ver '\'];
magnetic_dim=2;
max_rssi=-20;
min_rssi=-100;
if ~exist(save_path,'dir')
    mkdir (save_path);
end
is_average=false;
is_mixture=true;

% 载入数据
load(['data/fingerprints' data_version '.mat']);

%% 生成数据
if is_mixture
    data_type='training_gm';
else
    data_type='training_g';
end
for i=1:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    gsize=15*60*fps_rssi_freq(area_i);
    cdns_m=[];
    rssis_m=[];
    magnetics_m=[];
    rssi_mask=get_rssi_mask(fp);
    for r=1:fp.num
        tmp_cdn=fp.cdns(r,:);
        [timestamp,BSSID,RSSI,~]=loadWiFiData(fp.wfiles{r});
        tmp_rssi=get_rssis_timesequence(timestamp,BSSID,RSSI,fp.bssid_map,origin_time*fps_rssi_freq(area_i),rssi_mask);
        tmp_magnetics=get_magnetics_sequence(fp.sfiles{r},mag_cols,origin_time,fps_rssi_freq(area_i));
        if is_mixture
            new_rssi=generate_rssi(tmp_rssi,gsize);
            new_magnetics=generate_magnetic(tmp_magnetics,gsize);
            tmp_rssi=[tmp_rssi;new_rssi];
            tmp_magnetics=[tmp_magnetics;new_magnetics];
            RecordsNum=size(tmp_rssi,1);
            export_data_append;
        else
            tmp_rssi=generate_rssi(tmp_rssi,gsize);
            tmp_magnetics=generate_magnetic(tmp_magnetics,gsize);
            RecordsNum=gsize;
            export_data_append;
        end
        
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
%% 60s数据
% data_type='training_60';
% for i=1:length(areas)
%     area_i=areas(i);
%     fp=fps{area_i};
%     gsize=15*60*fps_rssi_freq(area_i);
%     cdns_m=[];
%     rssis_m=[];
%     magnetics_m=[];
%     rssi_mask=get_rssi_mask(fp);
%     for r=1:fp.num
%         tmp_cdn=fp.cdns(r,:);
%         [timestamp,BSSID,RSSI,~]=loadWiFiData(fp.wfiles{r});
%         tmp_rssi=get_rssis_timesequence(timestamp,BSSID,RSSI,fp.bssid_map,origin_time*fps_rssi_freq(area_i),rssi_mask);
%         tmp_magnetics=get_magnetics_sequence(fp.sfiles{r},mag_cols,origin_time);
%         RecordsNum=size(tmp_rssi,1);
%         export_data_append;
%     end
%     [mag_max,mag_min]=get_magnetic_statics(area_i,magnetic_dim);
%     [cdn_max,cdn_min]=get_cdns_statics(area_i);
%     cdns_m=cdns_m-cdn_min;
%     magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
%     rssis_m=my_norm(rssis_m,max_rssi,min_rssi);
%     m=[cdns_m magnetics_m rssis_m];
%     disp([save_path area_table{area_i}  '_' data_type '.csv']);
%     csvwrite([save_path area_table{area_i}  '_' data_type '.csv'],m);
% end
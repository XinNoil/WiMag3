clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load(['data/fingerprints' data_version '.mat']);

for i=1:length(area_table)
    fp=fps{i};
    gsize=15*60*fps_rssi_freq(i);
    for r=1:fp.num
        [timestamp,BSSID,RSSI,~]=loadWiFiData(fp.wfiles{r});
        tmp_rssi=get_rssis_timesequence(timestamp,BSSID,RSSI,fp.bssid_map);
        duties=get_duties_data(timestamp,BSSID,fp.bssid_map);
        new_rssi=generate_rssi(tmp_rssi,duties,gsize);
    end
end
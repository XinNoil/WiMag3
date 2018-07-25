%% Time Down Sampling
threshold = -80;
load(['data/fingerprints' data_version '.mat']);
for k=1:length(fps)
    fp = fps{k};
%     bssids = findAllAPFromPath(['original_data\' area_table{k} '\long'], threshold);
%     fp.bssid_map = containers.Map(bssids, 1:length(bssids));
    for m=1:length(fp.wfiles)
        [timestamp,bssid,rssi,~] = loadWiFiDataTimeDown(fp.wfiles{m}, 2);
    
        rssi_sum = zeros(1, fp.bssid_map.length);
        rssi_cnt = zeros(1, fp.bssid_map.length);
        for n=1:length(timestamp)
            if isKey(fp.bssid_map, bssid{n})&&rssi(n)>threshold
                bssid_index = fp.bssid_map(bssid{n});
                rssi_sum(bssid_index) = rssi_sum(bssid_index)+rssi(n);
                rssi_cnt(bssid_index) = rssi_cnt(bssid_index)+1;
            else
    %                 fprintf('%d %s %d in %s non-exist\n',time_index(n), bssid{n},rssi(n),filename);
            end
        end
        rssi_sum(rssi_cnt>0) = rssi_sum(rssi_cnt>0)./rssi_cnt(rssi_cnt>0);
        rssi_sum(rssi_cnt==0) = -100;
        fp.rssis{m} = rssi_sum;
    end
    fps{k} = fp;
end
save(['data/fingerprints_T' data_version '.mat'],'fps');
%% Location Down Sampling
load(['data/fingerprints' data_version '.mat']);
for k=1:length(fps)
    fp = fps{k};
    fp.cdns_mask = loadWiFiDataLocationDown(fp.settings, fp.cdns, 2, 1);
    fps{k} = fp;
end
save(['data/fingerprints_L' data_version '.mat'],'fps');
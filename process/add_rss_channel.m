% Date:     2018/08/23
% Auther:   WJK
% Function: This Script is used for adding rss channel field to fingerprints databases.
%           该脚本用于向指定数据库添加rss channel字段。
% Contact:  jiankunwang@tju.edu.cn

mh
ld
areas=1:length(area_table);
for area_i=areas
    fp=fps{area_i};
    if isfield(fp,'wfiles')
        fp.ap_num=length(fp.bssid_map);
        fp.bssids=keys(fp.bssid_map);
        fp.bssids_freq=zeros(fp.ap_num,1);
        for i=1:length(fp.wfiles)
            filename=fp.wfiles{i};
            [timestamp,BSSID,RSSI,Frequency]=loadWiFiData(filename);
            [bssid,ia,ic]=unique(BSSID);
            for j=1:length(ia)
                if(isKey(fp.bssid_map,bssid{j}))
                    ib=fp.bssid_map(bssid{j});
                    if fp.bssids_freq(ib)==0
                        fp.bssids_freq(ib)=Frequency(ia(j));
                    end
                end
            end
        end
    end
end
save(['data/fingerprints' data_version '.mat'],'fps');
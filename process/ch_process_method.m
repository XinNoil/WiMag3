% Date:     2018/08/29
% Auther:   WJK
% Function: This Script is used for change the process method of LIB-1-E's database.
%           New version (7.1) database ignoring the unreceived RSS.Do not counting them
%           when calculating the average RSS of reference point.
%           该脚本用于改变LIB-1-E的数据库。新版本(7.1)的数据库忽略了没有收到的数据。
%           在计算参考点RSS均值时没有计入未收到的RSS。
% Contact:  jiankunwang@tju.edu.cn

mh
ld
data_version='7.2';
save 'setting files'\glo.mat
area_i=4;
test_time=5;
fp=fps{area_i};
fp.rssi_mask=fp.rssi_mask_b;
for i=1:length(fp.wfiles)
    tmp_rssi=process_wifi_o(fp.wfiles{i},fp.bssid_map,'0',fps_rssi_freq(area_i),test_time);
    fp.rssis{i}=tmp_rssi;
end
fps{area_i}=fp;
save(['data/fingerprints' data_version '.mat'],'fps');
td=tds{area_i};
for i=1:length(td.wfiles)
    tmp_rssi=process_wifi_o(td.wfiles{i},fp.bssid_map,'1',tds_rssi_freq(area_i),test_time);
    td.rssis{i}=tmp_rssi;
end
tds{area_i}=td;
save(['data/testdatas' data_version '.mat'],'tds');
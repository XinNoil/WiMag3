function str = rssi_match( ti,fi )
%RSSI_MATCH 此处显示有关此函数的摘要
%   此处显示详细说明
disp(' ');
disp(['Test: ' num2str(ti) ' Rqs: ' num2str(fi)]);
load tmp/result_show.mat;
bssid_index=td.bssid_indexs{ti}(td.bssid_indexs{ti}>0);
s_rssi=td.rssis{ti}(int8(bssid_index));
disp(['test rssi ' num2str(ti)]);
disp(['index: ' num2str(bssid_index)]);
disp(['rssi: ' num2str(s_rssi)]);
clear bssid_index s_rssi
bssid_index=fp.bssid_indexs{fi}(fp.bssid_indexs{fi}>0);
s_rssi=fp.rssis{fi}(int8(bssid_index));
disp(['rqs rssi' num2str(fi)]);
disp(['index: ' num2str(bssid_index)]);
disp(['rssi: ' num2str(s_rssi)]);
search_rssi=fp.rssis{fi};
test_rssi=td.rssis{ti};
dis_feature=feature_match(parameters.distance_mode,search_rssi,test_rssi);
disp(['dis: ' num2str(dis_feature)]);
str=['H:' n2s(fp.magnetics(fi,1)) '  V:' n2s(fp.magnetics(fi,2))];
end


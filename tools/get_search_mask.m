function search_mask=get_search_mask(test_rssi,bssid_index,rssi_rqs_set)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
search_mask=true(length(rssi_rqs_set{1}),1);
bssid_index=bssid_index(bssid_index>0);
s_rssi=test_rssi(int8(bssid_index));
test_mask=s_rssi>-40;
s_index=bssid_index(test_mask);
for i=1:length(s_index)
    if sum(rssi_rqs_set{s_index(i)})>0
        search_mask=search_mask&rssi_rqs_set{s_index(i)};
    end
end


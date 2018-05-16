function test_data = get_testdata( td,i,is_rssi )
%GET_TESTDATA 此处显示有关此函数的摘要
%   此处显示详细说明
test_data.i=i;
test_data.cdn=td.cdns(i,:);
test_data.magnetic=td.magnetics(i,:);
test_data.magnitude=td.magnitudes(i,:);
if is_rssi
    test_data.rssi=td.rssis{i};
    test_data.bssid_map=td.bssid_maps{i};
    test_data.bssid_index=td.bssid_indexs{i};
end
end
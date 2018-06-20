function test_data = get_testdata( db,i,is_rssi )
%GET_TESTDATA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
test_data.i=i;
test_data.cdn=db.cdns(i,:);
test_data.magnetic=db.magnetics(i,:);
test_data.magnitude=db.magnitudes(i,:);
if is_rssi
    test_data.rssi=db.rssis{i};
    test_data.bssid_map=db.bssid_maps{i};
    test_data.bssid_index=db.bssid_indexs{i};
end
end
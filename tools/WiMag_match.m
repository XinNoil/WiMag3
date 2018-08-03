function result = WiMag_match( fp,test_data,parameters)
[feature_mode,distance_mode,K,~,~,is_testdata] = get_parameters( parameters );
max_rssi=-20;
min_rssi=-100;
rssi_mask=parameters.rssi_mask;
search_mask=true(fp.num,1);
if ~is_testdata
    search_mask(test_data.i)=false;
end
switch feature_mode
    case 'M'
        search_feature=fp.magnitudes(search_mask,:);
        test_feature=test_data.magnitude;
    case 'MM'
        search_feature=fp.magnetics(search_mask,:);
        test_feature=test_data.magnetic;
    case 'R'
        fp_rssis=cell2mat(fp.rssis);
        search_feature=fp_rssis(search_mask,rssi_mask);
        test_feature=test_data.rssi;
    case 'RM'
        fp_rssis=cell2mat(fp.rssis);
        search_magnitudes=my_norm(fp.magnitudes(search_mask,:),fp.magni_max,fp.magni_min);
        search_rssis=my_norm(fp_rssis(search_mask,rssi_mask),max_rssi,min_rssi);
        search_feature=[search_magnitudes search_rssis];
        test_magnitude=my_norm(test_data.magnitude,fp.magni_max,fp.magni_min);
        test_rssi=my_norm(test_data.rssi,max_rssi,min_rssi);
        test_feature=[test_magnitude test_rssi];
    case 'RMM'
        fp_rssis=cell2mat(fp.rssis);
        search_magnetics=fp.magnetics(search_mask,:);
        search_rssis=fp_rssis(search_mask,rssi_mask);
        search_magnetics=my_norm(search_magnetics,fp.mag_max,fp.mag_min);
        search_rssis=my_norm(search_rssis,max_rssi,min_rssi);
        search_feature=[search_magnetics search_rssis];
        test_magnetic=my_norm(test_data.magnetic,fp.mag_max,fp.mag_min);
        test_rssi=my_norm(test_data.rssi,max_rssi,min_rssi);
        test_feature=[test_magnetic test_rssi];
end
search_num=sum(search_mask);
search_dis=zeros(search_num,1);
search_dis_feature=zeros(search_num,1);
search_cdns=fp.cdns(search_mask,:);

for i=1:search_num
    search_dis_feature(i)=feature_match(distance_mode,search_feature(i,:),test_feature);
    search_dis(i)=distance(search_cdns(i,:),test_data.cdn);
end
[~,index]=sort(search_dis_feature); %sort_dis_feature
result_mask=index(1:K);
topk_cdn=search_cdns(result_mask,:);
result.result_cdn=mean(topk_cdn,1);
result.result_err=distance(test_data.cdn,result.result_cdn);
result.test_cdns=test_data.cdn;
result.test_data=test_data;
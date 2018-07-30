function result = WiMag_match( fp,test_data,parameters)
%WiMag_match_rssi 
%%   Ê¹ÓÃWiFiÉ¸Ñ¡
[feature_mode,distance_mode,K,~,~,is_testdata] = get_parameters( parameters );
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
        search_feature=[fp.magnitudes(search_mask,:) fp_rssis(search_mask,rssi_mask)];
        test_feature=[test_data.magnitude test_data.rssi];
    case 'RMM'
        fp_rssis=cell2mat(fp.rssis);
        search_feature=[fp.magnetics(search_mask,:) fp_rssis(search_mask,rssi_mask)];
        test_feature=[test_data.magnetic test_data.rssi];
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
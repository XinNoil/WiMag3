function result = WiMag_match_wifi( fp,test_data,parameters)
%WiMag_match_rssi 
%%   使用WiFi筛选
[ feature_mode,distance_mode,K,threshold_rssi,center_weight ] = get_parameters( parameters );
index_mask=true(1,length(test_data.rssi));

search_mask=true(fp.num,1);
if parameters.bpca=='N'
    fp_rssis=cell2mat(fp.rssis);
    test_rssi=test_data.rssi;
    search_rssis=fp_rssis(search_mask,index_mask);
else
    fp_rssis=fp.rssis_pca;
    score=bsxfun(@minus,test_data.rssi,fp.rssis_mean)*fp.rssis_coef;
    test_rssi=score(:,1:fp.rssis_r);
    search_rssis=fp_rssis(search_mask,:);
end
search_cdns=fp.cdns(search_mask,:);
search_num=size(search_rssis,1);
fs.distance_mode=distance_mode;
fs.weight=parameters.feature_weight;
wcs.mode='M';
wcs.weights=zeros(search_num,1);
for i=1:search_num
    wcs.weights(i)=sum(search_rssis(i,:)>-70)+1;
end 
[ rssi_topk_cdns,...
    rssi_index,...
    rssi_dis_feature,...
    rssi_result_cdn,...
    rssi_result_errs,...
    rssi_result] = myKNN( fs,wcs,3,test_rssi,test_data.cdn,search_rssis,search_cdns );

ed2_tkc_r=EuDist2(rssi_topk_cdns);
avgpd_k_r=(sum(ed2_tkc_r(:)))/6;
% wifi结果
result.wifi_cdn=rssi_result_cdn;
result.wifi_err=distance(test_data.cdn,rssi_result_cdn);
result.rssi_topk_cdns=rssi_topk_cdns;
result.avgpd_k_r=avgpd_k_r;
result.rssi_result=rssi_result;
end

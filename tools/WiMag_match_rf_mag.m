function result = WiMag_match_rf_mag( fp,test_data,parameters)
%WiMag_match_rf_mag 
%% WiFi筛选阶段
[ feature_mode,distance_mode,K,threshold_rssi,center_weight,is_testdata ] = get_parameters( parameters );
index_mask=true(1,length(test_data.rssi));
search_mask=true(fp.num,1);
if ~is_testdata
    search_mask(test_data.i)=false;
end
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
cs.mode='N';
[ rssi_topk_cdns,...
    rssi_index,...
    rssi_dis_feature,...
    rssi_result_cdn,...
    rssi_result_errs,...
    rssi_result] = myKNN( distance_mode,cs,3,test_rssi,test_data.cdn,search_rssis,search_cdns );
%% 构造候选集
if(parameters.binterp=='N')
    search_magnetics=fp.magnetics(search_mask,:);
else
    search_cdns=fp.cdns_i;
    search_magnetics=fp.magnetics_i;
end
search_dis=mnorm(search_cdns-rssi_result_cdn,2);
candidate_mask=search_dis<=threshold_rssi;
candidate_num=sum(candidate_mask);
if candidate_num==0
    candidate_mask=search_dis==min(search_dis);
    candidate_num=1;
end
candidate_cdns=search_cdns(candidate_mask,:);
candidate_feature=[search_magnetics(candidate_mask,:)];
test_feature=test_data.magnetic;
%{
% switch feature_mode
%     case 'W1'
%         candidate_feature=[search_magnetics(candidate_mask,:)];
%         test_feature=test_data.magnetic;
%     otherwise
%         candidate_feature=[search_magnetics(candidate_mask,:)];
%         test_feature=test_data.magnetic;
% %         options = [];
% %         options.NeighborMode = 'SupervisedR';
% %         options.tk = 1;
% %         options.gnd=candidate_cdns;
% %         W = constructW(candidate_feature,options);
% %         [laplacianScore] = LaplacianScore(candidate_feature,W);
% %         fisherScore=abs(1-1./abs(laplacianScore));
% %         fisherScore=1./fisherScore;
% %         feature_weight=fisherScore/sum(fisherScore);
% end
%}

%% Magnetism再定位阶段
clear cs
cs.mode=center_weight;
[ topk_cdns,...
    index,...
    dis_feature,...
    result_cdns,...
    result_errs,...
    result_dis,...
    mag_result] = myKNN( distance_mode,cs,1:K,test_feature,test_data.cdn,candidate_feature,candidate_cdns );

avgpd_k=zeros(K,1);
ed2_tkc=EuDist2(topk_cdns);
ed2_tkc_r=EuDist2(rssi_topk_cdns);
for i=2:K
    avgpd_k(i)=sum(sum(ed2_tkc(1:i,1:i)))/((i-1)*i);
end
avgpd_k_r=sum(sum(ed2_tkc_r(:)))/6;

%% 构造结果
% wifi结果
result.wifi_cdn=rssi_result_cdn;
result.wifi_err=distance(test_data.cdn,rssi_result_cdn);
result.rssi_topk_cdns=rssi_topk_cdns;
result.avgpd_k_r=avgpd_k_r;
result.rssi_result=rssi_result;
% 候选集
result.candidate_cdns=candidate_cdns;
% mag结果
result.result_cdn=result_cdns;
result.result_err=result_errs;
result.topk_cdns=topk_cdns;
result.avgpd_k=avgpd_k;
result.mag_result=mag_result;

end

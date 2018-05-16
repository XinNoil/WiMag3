function result = WiMag_match_fusion( fp,test_data,parameters)
%WIMAG_MATCH_FUSION 此处显示有关此函数的摘要
%   此处显示详细说明 
%% WiFi筛选阶段
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
search_magnetics=fp.magnetics(search_mask,:);
search_num=size(search_rssis,1);
cs.mode='N';
[ rssi_topk_cdns,...
    rssi_index,...
    rssi_dis_feature,...
    rssi_result_cdn,...
    rssi_result_err,...
    rssi_result ] = myKNN( distance_mode,cs,3,test_rssi,test_data.cdn,search_rssis,search_cdns );
search_dis=zeros(search_num,1);
for i=1:search_num
    search_dis(i)=distance(search_cdns(i,:),rssi_result_cdn);
end 
candidate_mask=search_dis<=threshold_rssi;
candidate_num=sum(candidate_mask);
if candidate_num==0
    candidate_mask=search_dis==min(search_dis);
    candidate_num=1;
end
candidate_cdns=search_cdns(candidate_mask,:);
candidate_feature=[search_magnetics(candidate_mask,:)];
test_feature=test_data.magnetic;
%% Magnetism 再定位阶段
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
%% Magnetism & WiFi 融合
if parameters.predict_method==1
    p1=parameters.error_predict_para{2}(1);
    p2=parameters.error_predict_para{2}(2);
    em=avgpd_k(3)*p1+p2;
elseif parameters.predict_method==2
    p1=parameters.error_predict_para{3}(1);
    p2=parameters.error_predict_para{3}(2);
    em=avgpd_k(3)/avgpd_k(10)*p1+p2;
end
p1=parameters.error_predict_para{1}(1);
p2=parameters.error_predict_para{1}(2);
ew=avgpd_k_r*p1+p2;
result.pre_err=em-result_errs(3);
result.pre_err_w=ew-rssi_result_err;

if em<=parameters.error_predict_para{4}
    em=0;
    ew=1;  
end
wm=ew/(em+ew);
ww=em/(em+ew);
dm=dis_feature;
dw=rssi_dis_feature(candidate_mask);
dm=dm./max(dm);
dw=dw./max(dw);
dm=dm.*wm;
dw=dw.*ww;
fs.distance_mode=distance_mode;
fs.dis_feature=dw+dm;
[ topk_cdns_f,...
    index_f,...
    dis_feature_f,...
    result_cdns_f,...
    result_errs_f,...
    result_dis_f,...
    f_result] = myKNN( fs,cs,1:K,[],test_data.cdn,[],candidate_cdns );
%% 构造结果
% wifi结果
result.wifi_cdn=rssi_result_cdn;
result.wifi_err=rssi_result_err;
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
% 融合结果
result.result_cdns_f=result_cdns_f;
result.result_errs_f=result_errs_f;
result.f_result=f_result;

end

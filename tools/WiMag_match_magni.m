function result = WiMag_match_magni( fp,test_data,parameters)
%WiMag_match_rssi 
%   仅使用RSSI进行KNN匹配（RADAR）
distance_mode=parameters.distance_mode;
center_weight=parameters.center_weight;
K=parameters.K;
% convert_mode=parameters.convert_mode;
if(fp.num~=size(fp.cdns,1))
    disp('WARNING: 数据库参考点数量不一致');
end
search_mask= true(fp.num,1);
% search_mask(test_data.no)=false;
search_num=sum(search_mask);
search_dis=zeros(search_num,1);
search_dis_feature=zeros(search_num,1);
search_cdns=fp.cdns(search_mask,:);
search_feature=fp.magnitudes(search_mask,:);
real_neighbour=false(search_num,1);
for i=1:search_num
    search_magnitude=search_feature(i,:);
    test_magnitude=test_data.magnitude;
    search_dis_feature(i)=feature_match(distance_mode,search_magnitude,test_magnitude);
    search_dis(i)=distance(search_cdns(i,:),test_data.cdn);
    if search_dis(i)<=2
        real_neighbour(i)=true;
    end
end
[sort_dis_rssi,index]=sort(search_dis_feature);
% [~,r_index]=sort(index);
% RN_rank=r_index(real_neighbour);
% TopK_dis=search_dis(index(1:K));
result_cdn=zeros(K,2);
result_err=zeros(1,K);
% disp(['待测点坐标:' num2str(test_data.cdn(1)) ' ' num2str(test_data.cdn(2))]);
for k=1:K
    if (length(index)>k)
        result_mask=index(1:k);
    else
        result_mask=index;
    end
    topk_cdn=search_cdns(result_mask,:);
    if center_weight=='w'
        weight=1./sort_dis_rssi(1:k);
        weight=weight./sum(weight);
        result_cdns(:,1)=topk_cdn(:,1).*weight;
        result_cdns(:,2)=topk_cdn(:,2).*weight;
        result_cdn(k,:)=sum(result_cdns,1);
    else
        result_cdn(k,:)=mean(topk_cdn,1);
    end
    result_err(k)=distance(test_data.cdn,result_cdn(k,:));
%     disp(['K=' num2str(k) ' 结果坐标: ' num2str(result_cdn(1)) ' ' num2str(result_cdn(2)) ' 误差: ' num2str(result_err(k))]);
end
result.result_cdn=result_cdn;
result.result_err=result_err;
result.topk_cdn=topk_cdn;
end
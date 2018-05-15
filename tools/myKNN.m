function [ topk_cdns,index,dis_feature,result_cdns,result_errs,result_dis,result ] = myKNN( feature_setting,center_setting,K,test_feature,test_cdn,search_features,search_cdns,varargin )
%MYKNN 此处显示有关此函数的摘要
%   此处显示详细说明
%% 赋值dis_feature
search_num=size(search_features,1);
if isstruct(feature_setting)
    distance_mode=feature_setting.distance_mode;
else
    distance_mode=feature_setting;
end
if isfield(feature_setting,'dis_feature')
    dis_feature=feature_setting.dis_feature;
else
    dis_feature=zeros(search_num,1);
    for i=1:search_num
        if iscell(search_features)
            search_feature=search_features{i};
        else
            search_feature=search_features(i,:);
        end
        dis_feature(i)=feature_match(distance_mode,search_feature,test_feature);
    end
end
[dis_feature_s,index]=sort(dis_feature);
%% 赋值Top K
k_num=length(K);
result_cdns=zeros(k_num,2);
result_errs=zeros(k_num,1);
result_dis=zeros(k_num,1);
for i=1:k_num
    k=K(i);
    if (length(index)>k)
        result_mask=index(1:k);
    else
        result_mask=index;
    end
    topk_cdns=search_cdns(result_mask,:);
    if center_setting.mode=='W'
        weighted_topk_cdns=zeros(size(topk_cdns));
        if (length(index)>k)
            weight=1./dis_feature_s(1:k);
        else
            weight=1./dis_feature_s;
        end
        weight=weight./sum(weight);
        weighted_topk_cdns(:,1)=topk_cdns(:,1).*weight;
        weighted_topk_cdns(:,2)=topk_cdns(:,2).*weight;
        result_cdns(i,:)=sum(weighted_topk_cdns,1);
    elseif center_setting.mode=='M'
        weights=center_setting.weights;
        weights_s=weights(index);
        if (length(index)>k)
            weight=weights_s(1:k);
        else
            weight=weights_s;
        end
        weight=weight./sum(weight);
        weighted_topk_cdns(:,1)=topk_cdns(:,1).*weight;
        weighted_topk_cdns(:,2)=topk_cdns(:,2).*weight;
        result_cdns(i,:)=sum(weighted_topk_cdns,1);
    else
        result_cdns(i,:)=mean(topk_cdns,1);
    end
    if k<=length(dis_feature_s)
        result_dis(i)=mean(dis_feature_s(1:k));
    else
        result_dis(i)=mean(dis_feature_s);
    end
    result_errs(i)=distance(test_cdn,result_cdns(i,:));
end
topk_cdns=[topk_cdns;topk_cdns(end,:).*ones(max(K)-size(topk_cdns,1),2)];
result.topk_cdns=topk_cdns;
result.index=index;
result.dis_feature=dis_feature;
result.result_cdns=result_cdns;
result.result_errs=result_errs;
result.result_dis=result_errs;
end


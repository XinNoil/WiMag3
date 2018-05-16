function show_match_results(result,type,str)
%SHOMATCHRESULTS 此处显示有关此函数的摘要
%   此处显示详细说明
    strs={};
    test_data=result.test_data;
    H(1)=plot(test_data.cdn(1),test_data.cdn(2),'ro');
    set(H(1),'markersize',10,'markerfacecolor','r');
    switch lower(type)
        case 'wifi'
            err=result.wifi_err;
            topk_cdns=result.rssi_topk_cdns;
        case 'mag'
            test_data.magnitude=norm(test_data.magnetic);
            err=result.result_err(3);
            topk_cdns=result.topk_cdn;
            candidate_cdns=result.candidate_cdns;
            H(end+1)=plot(candidate_cdns(:,1),candidate_cdns(:,2),'k*');
            strs{end+1}=['magnetics: ' num2str(test_data.magnetic(1)) ' ' num2str(test_data.magnetic(2))];
            strs{end+1}=['magnitude: ' num2str(test_data.magnitude)];
    end
    H(end+1)=plot(topk_cdns(1:3,1),topk_cdns(1:3,2),'g*');
    if size(topk_cdns,1)>3
        H(end+1)=plot(topk_cdns(4:end,1),topk_cdns(4:end,2),'m*');
    end
    strs{end+1}=['Error: ' num2str(err)];
    if exist('str','var')
        strs{end+1}=str;
    end
    H(end+1)=legend(gca,'location','westoutside',strs);
    if isfield(result,{'wifi_cdn'})
        H(end+1)=plot(result.wifi_cdn(1),result.wifi_cdn(2),'ko');
        set(H(end),'markersize',7,'markerfacecolor','k');
    end     
end
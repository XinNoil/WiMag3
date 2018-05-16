function H=show_match_result( result,str)
%SHOWMATCHRESULT 此处显示有关此函数的摘要
%   此处显示详细说明
    test_data=result.test_data;
    test_data.magnitude=norm(test_data.magnetic);
    err=result.result_err;
    topk_cdns=result.topk_cdns;
    candidate_cdns=result.candidate_cdns;
    H(1)=plot(test_data.cdn(1),test_data.cdn(2),'ro');
    set(H(1),'markersize',10,'markerfacecolor','r');
    H(2)=plot(candidate_cdns(:,1),candidate_cdns(:,2),'k*');
    H(3)=plot(topk_cdns(1:3,1),topk_cdns(1:3,2),'g*');
    H(4)=plot(topk_cdns(4:end,1),topk_cdns(4:end,2),'m*');
    if nargin==1
        H(5)=legend(gca,'location','westoutside',['magnetics: ' num2str(test_data.magnetic(1)) ' ' num2str(test_data.magnetic(2))] ,['magnitude: ' num2str(test_data.magnitude)],['Error: ' num2str(err(3))]);
    else 
        H(5)=legend(gca,'location','westoutside',['magnetics: ' num2str(test_data.magnetic(1)) ' ' num2str(test_data.magnetic(2))] ,['magnitude: ' num2str(test_data.magnitude)],['Error: ' num2str(err(3))],str);
    end
    if isfield(result,{'wifi_cdn'})
        H(6)=plot(result.wifi_cdn(1),result.wifi_cdn(2),'ko');
        set(H(6),'markersize',7,'markerfacecolor','k');
    end     
end


function result = results2result( results )
%RESULTS2RESULT 此处显示有关此函数的摘要
%   此处显示详细说明
result.cdn={results(:).result_cdn}';
result.topk_cdn={results(:).topk_cdn}';
result.err=reshape([results(:).result_err],length(results(1).result_err),length(results))';
if isfield(results(1),{'candidate_cdns'})
    result.candidate_cdns={results(:).candidate_cdns}';
end
result.test_cdns=reshape([results(:).test_cdns],2,length(results))';
result.test_data={results(:).test_data}';
if isfield(results(1),{'wifi_cdn'})
    result.wifi_cdn={results(:).result_cdn}';
    result.wifi_err=[results(:).wifi_err]';
end
end


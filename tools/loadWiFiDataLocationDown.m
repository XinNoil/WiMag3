function mask = loadWiFiDataLocationDown(settings, cdns, rfreq, cfreq)
% 对fingerprints的数据按换位置进行下采样
% 输入: fps.settings，fps.cdns, 行采样频率，列采样频率
%       注: 采样频率为1表示每一行(列)采一个，2表示每两行(列)采一个，...
% 输出: cdns的mask向量，1表示被采样到的点
% Author: S.E.Wei
    rows = [];
    cols = [];
    for m=1:length(settings)
        area_rows = [];
        area_cols = [];
        for n=1:length(settings{m}.gridmesh)
            if settings{m}.gridmesh(n).type=='0'
                area_rows = [area_rows settings{m}.gridmesh(n).row_index]+settings{m}.origin(1);
                area_cols = [area_cols settings{m}.gridmesh(n).column_index]+settings{m}.origin(2);
            end
        end
        rows = [rows area_rows(mod([1:length(area_rows)] -1, rfreq)~=0)];
        cols = [cols area_cols(mod([1:length(area_cols)] -1, cfreq)~=0)];
    end
    mask = true(length(cdns),1);
    for m=1:length(rows)
        indexs = abs(cdns(:,1)-rows(m))<1e-6;
        mask(indexs) = 0;
    end
    for m=1:length(cols)
        indexs = abs(cdns(:,2)-cols(m))<1e-6;
        mask(indexs) = 0;
    end
end


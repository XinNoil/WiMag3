% Date:     2018/5/22
% Auther:   WJK
% Function: The script extracts fingerprints from several sub-regions
%           该脚本将若干子区域的指纹库提取出来
% Contact:  jiankunwang@tju.edu.cn

clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

% 参数设置
areas=[1 2 4 5];
sub_grid_size=5.001; % 子区域大小
is_overlapped=false;
mag_cols=18:20;
test_time=2;

% 载入数据
load (['data/testdatas' data_version '.mat']);

% 循环分割
for area_i=areas
    td=tds{area_i};
    tdcdns=td.cdns;
    sub_i_t=td.sub_i;
    sub_i_list_t=unique(sub_i_t);
    sub_tds=cell(1,length(sub_i_list_t));
    for j=1:length(sub_i_list_t)
        tmp_i=sub_i_list_t(j);
        tmp_mask=sub_i_t==tmp_i;
        subtd.i_area=td.i_area;
        subtd.ws=floor(tmp_i/100);
        subtd.sub_i=tmp_i;
        subtd.bssid_map=td.bssid_map;
        cdns=td.cdns(tmp_mask,:);
        wfiles=td.wfiles(tmp_mask);
        sfiles=td.sfiles(tmp_mask);
        subtd.cdns=[];
        subtd.rssi=[];
        subtd.magnetics=[];
        for p=1:length(wfiles)
            tmp_cdn=cdns(p,:);
            [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(wfiles{p},td.bssid_map);
            tmp_magnetics=process_magnetic(sfiles{p},RecordsNum,mag_cols,test_time);
            subtd.cdns=[subtd.cdns ; repmat( tmp_cdn , RecordsNum , 1 )];
            subtd.magnetics=[subtd.magnetics ; tmp_magnetics];
            subtd.rssi=[subtd.rssi ; tmp_rssi];
        end
        sub_tds{j}=subtd;
    end
    disp(['data/testdatas' data_version 's_' area_table{area_i} '.mat']);
    save (['data/testdatas' data_version 's_' area_table{area_i} '.mat'],'sub_tds');
end
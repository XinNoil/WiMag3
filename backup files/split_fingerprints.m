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
load (['data/fingerprints' data_version '.mat']);

% 循环分割
for area_i=areas
    fp=fps{area_i};
    cdns=fp.cdns;
    sub_i=fp.sub_i;
    sub_i_list=unique(sub_i);
    sub_fps=cell(1,length(sub_i_list));
    for j=1:length(sub_i_list)
        tmp_i=sub_i_list(j);
        tmp_mask=sub_i==tmp_i;
        subfp.i_area=fp.i_area;
        subfp.ws=floor(tmp_i/100);
        subfp.sub_i=tmp_i;
        subfp.bssid_map=fp.bssid_map;
        cdns=fp.cdns(tmp_mask,:);
        wfiles=fp.wfiles(tmp_mask);
        sfiles=fp.sfiles(tmp_mask);
        subfp.num=length(wfiles);
        subfp.cdns_m=[];
        subfp.rssis_m=[];
        subfp.magnetics_m=[];
        subfp.cdns=fp.cdns(tmp_mask,:);
        subfp.rssis=fp.rssis(tmp_mask,:);
        subfp.magnetics=fp.magnetics(tmp_mask,:);
        subfp.rssi_mask=fp.rssi_mask;
        for p=1:length(wfiles)
            tmp_cdn=cdns(p,:);
            [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(wfiles{p},fp.bssid_map);
            tmp_magnetics=process_magnetic(sfiles{p},RecordsNum,mag_cols,test_time);
            subfp.cdns_m=[subfp.cdns_m ; repmat( tmp_cdn , RecordsNum , 1 )];
            subfp.magnetics_m=[subfp.magnetics_m ; tmp_magnetics];
            subfp.rssis_m=[subfp.rssis_m ; tmp_rssi];
        end
        sub_fps{j}=subfp;
    end
    disp(['data/fingerprints' data_version 's_' area_table{area_i} '.mat']);
    save (['data/fingerprints' data_version 's_' area_table{area_i} '.mat'],'sub_fps');
end
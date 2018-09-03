clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

% 参数设置
areas=4;%[1 2 4 5 10 11 14];
test_mode=0; % 0 testing
mag_cols=18:20;
test_time=1;
data_ver='2';
save_path=[deeploc_path '\data\' data_ver '\'];
label_type='deeploc';
magnetic_dim=2;
max_rssi=-20;
min_rssi=-85;
is_average=true;
area_label='';
if ~exist(save_path,'dir')
    mkdir (save_path);
end

% 载入数据
load (['data/fingerprints' data_version '.mat']);
load (['data/testdatas' data_version '.mat']);

% remove_no=[75 145 215 216];
% remove_no=[1,27,50,165,299,357,102,369];
test_mode_str={'','_1','_2'};
remove_no=[];
data_type=['testing' test_mode_str{test_mode+1}];

for i=1:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    td=tds{area_i};
    cdns_m=[];
    rssis_m=[];
    magnetics_m=[];
    rssi_mask=get_rssi_mask(fp);
    switch test_mode
        case 0
            td_no=1:td.num;
            td_no(remove_no)=[];
            for t=td_no
                tmp_cdn=td.cdns(t,:);
                [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(td.wfiles{t},fp.bssid_map,'1',tds_rssi_freq(area_i),test_time,rssi_mask);
                tmp_magnetics=process_magnetic(td.sfiles{t},RecordsNum,mag_cols,test_time);
                export_data_append;
            end
        case 1
            for r=1:fp.num
                tmp_cdn=fp.cdns(r,:);
                [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(fp.wfiles{r},fp.bssid_map,'1',fps_rssi_freq(area_i),test_time,rssi_mask);
                tmp_magnetics=process_magnetic(fp.sfiles{r},RecordsNum,mag_cols,test_time);
                export_data_append;
            end
        case 2
            td_no=1:td.num;
            td_no(remove_no)=[];
            for t=td_no
                tmp_cdn=td.cdns(t,:);
                [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(td.wfiles{t},fp.bssid_map,'1',tds_rssi_freq(area_i),test_time,rssi_mask);
                tmp_magnetics=process_magnetic(td.sfiles{t},RecordsNum,mag_cols,test_time);
                export_data_append;
            end
            for r=1:fp.num
                tmp_cdn=fp.cdns(r,:);
                [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(fp.wfiles{r},fp.bssid_map,'1',fps_rssi_freq(area_i),test_time,rssi_mask);
                tmp_magnetics=process_magnetic(fp.sfiles{r},RecordsNum,mag_cols,test_time);
                export_data_append;
            end
    end
    [mag_max,mag_min]=get_magnetic_statics(area_i,magnetic_dim);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    cdns_m=cdns_m-cdn_min;
    magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
    rssis_m=my_norm(rssis_m,max_rssi,min_rssi);
    m=[cdns_m magnetics_m rssis_m];
    disp([save_path area_table{area_i} area_label '_' data_type '.csv']);
    csvwrite([save_path area_table{area_i} area_label '_' data_type '.csv'],m);
end
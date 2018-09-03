%%
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

% 参数设置
areas=15;
mag_cols=18:20;
test_time=895;
data_ver='1';
save_path=[deeploc_path '\data\' data_ver '\'];
magnetic_dim=2;
max_rssi=-20;
min_rssi=-100;
is_average=false;
if ~exist(save_path,'dir')
    mkdir (save_path);
end

% 载入数据
load (['data/fingerprints' data_version '.mat']);
load (['data/testdatas' data_version '.mat']);

%% area predict train
% for i=1:length(areas)
%     area_i=areas(i);
%     data_description.magnetic_dim=magnetic_dim;
%     data_description.rssi_dim=fps{area_i}.rssi_mask_num;
%     save_json([save_path area_table{area_i}  '_data_description.json'],data_description);
% end
%% training data
% data_type='training';
% for i=1:length(areas)
%     area_i=areas(i);
%     fp=fps{area_i};
%     rssis_inputs=cell(1,fp.num);
%     cdns_ms=cell(1,fp.num);
%     magnetics_ms=cell(1,fp.num);
%     rssi_mask=get_rssi_mask(fp);
%     for r=1:fp.num
%         [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(fp.wfiles{r},fp.bssid_map,'0',fps_rssi_freq(area_i),test_time,rssi_mask);
%         RecordsNum=8955-test_time*5;
%         tmp_rssi=tmp_rssi(1:RecordsNum,:);
%         rssis_inputs{r}=tmp_rssi;
%         tmp_label=fp.rssis{r};
%         disp(RecordsNum);
%         tmp_cdn=fp.cdns(r,:);
%         tmp_magnetics=process_magnetic(fp.sfiles{r},RecordsNum,mag_cols,test_time);
%         cdns_ms{r}=repmat( tmp_cdn , RecordsNum , 1 );
%         magnetics_ms{r}=tmp_magnetics;
%     end
%     rssis_input=zeros(RecordsNum*fp.num,size(tmp_rssi,2));
%     cdns_m=zeros(RecordsNum*fp.num,2);
%     magnetics_m=zeros(RecordsNum*fp.num,2);
%     for r=1:fp.num
%         rssis_input(r:fp.num:end,:)=rssis_inputs{r};
%         cdns_m(r:fp.num:end,:)=cdns_ms{r};
%         magnetics_m(r:fp.num:end,:)=magnetics_ms{r};
%     end
%     rssis_input=my_norm(rssis_input,max_rssi,min_rssi);
%     [mag_max,mag_min]=get_magnetic_statics(area_i,magnetic_dim);
%     [cdn_max,cdn_min]=get_cdns_statics(area_i);
%     cdns_m=cdns_m-cdn_min;
%     magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
%     m=[cdns_m magnetics_m rssis_input];
%     disp([save_path area_table{area_i}  '_' data_type '.csv']);
%     csvwrite([save_path area_table{area_i}  '_' data_type '.csv'],m);
% end
%% testing data
is_average=false;
test_mode_str={'','_1','_2'};
remove_no=[];

for i=1:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    td=tds{area_i};
    rssi_mask=get_rssi_mask(fp);
    for test_mode=0:2
        cdns_m=[];
        rssis_m=[];
        magnetics_m=[];
        data_type=['testing' test_mode_str{test_mode+1}];
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
        disp([save_path area_table{area_i} '_' data_type '.csv']);
        csvwrite([save_path area_table{area_i} '_' data_type '.csv'],m);
    end
end
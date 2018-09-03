%%
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

% 参数设置
areas=[10];
mag_cols=18:20;
test_time=1;
data_ver='0';
save_path=[deeploc_path '\data\' data_ver '\'];
label_type='soft';
magnetic_dim=2;
max_rssi=-20;
min_rssi=-100;
if ~exist(save_path,'dir')
    mkdir (save_path);
end

% 载入数据
load (['data/fingerprints' data_version '.mat']);
load (['data/testdatas' data_version '.mat']);

% remove_no=[75 145 215 216];
% remove_no=[1,27,50,165,299,357,102,369];
remove_no=[];
%% area predict train
for i=1:length(areas)
    area_i=areas(i);
    data_description.class_num=size(fps{area_i}.categorical_vector,2);
    data_description.label_type=label_type;
    data_description.magnetic_dim=magnetic_dim;
    data_description.rssi_dim=length(fps{area_i}.bssid_map);
    save_json([save_path area_table{area_i} '_' label_type  '_data_description.json'],data_description);
end
%% area predict train
data_type='training';
for i=1:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    categorical_vector_m=[];
    cdns_m=[];
    rssis_m=[];
    magnetics_m=[];
    for r=1:fp.num
        tmp_cdn=fp.cdns(r,:);
        [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(fp.wfiles{r},fp.bssid_map,'0',fps_rssi_freq(area_i),test_time);
        tmp_magnetics=process_magnetic(fp.sfiles{r},RecordsNum,mag_cols,test_time);
        categorical_vector_m=[categorical_vector_m ; repmat(fp.categorical_vector(r,:),RecordsNum,1)];
        export_data_append;
    end
    [mag_max,mag_min]=get_magnetic_statics(area_i,magnetic_dim);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    cdns_m=cdns_m-cdn_min;
    magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
    rssis_m=(rssis_m-min_rssi)/(max_rssi-min_rssi);
    rssis_m(rssis_m<0)=0;
    rssis_m(rssis_m>1)=1;
    m=[categorical_vector_m cdns_m magnetics_m rssis_m];
    disp([save_path area_table{area_i} '_' label_type '0_' data_type '.csv']);
    csvwrite([save_path area_table{area_i} '_' label_type '0_' data_type '.csv'],m);
end

%% cdn predict test
data_type='testing';
for i=1:length(areas)
    area_i=areas(i);
    fp=fps{area_i};
    td=tds{area_i};
    categorical_vector_m=[];
    cdns_m=[];
    rssis_m=[];
    magnetics_m=[];
    td_no=1:td.num;
    td_no(remove_no)=[];
    for t=td_no
        tmp_cdn=td.cdns(t,:);
        [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(td.wfiles{t},fp.bssid_map,'1',tds_rssi_freq(area_i),test_time);
        tmp_magnetics=process_magnetic(td.sfiles{t},RecordsNum,mag_cols,test_time);
        categorical_vector_m=[categorical_vector_m ;  repmat(td.categorical_vector(t,:),RecordsNum,1)];
        export_data_append;
    end
    [mag_max,mag_min]=get_magnetic_statics(area_i,magnetic_dim);
    [cdn_max,cdn_min]=get_cdns_statics(area_i);
    cdns_m=cdns_m-cdn_min;
    magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
    rssis_m=(rssis_m-min_rssi)/(max_rssi-min_rssi);
    rssis_m(rssis_m<0)=0;
    rssis_m(rssis_m>1)=1;
    m=[categorical_vector_m cdns_m magnetics_m rssis_m];
    disp([save_path area_table{area_i} '_' label_type '0_' data_type '.csv']);
    csvwrite([save_path area_table{area_i} '_' label_type '0_' data_type '.csv'],m);
end

%% cdn predict test
% for i=1:length(areas)
%     area_i=areas(i);
%     fp=fps{area_i};
%     area_code_num=size(fp.categorical_vector,2);
%     for area_code=1:area_code_num
%         area_mask=fp.categorical_vector(:,area_code)>0;
%         cdns_m=[];
%         rssis_m=[];
%         magnetics_m=[];
%         
%         subfp.i_area=fp.i_area;
%         subfp.sub_i=area_code;
%         subfp.bssid_map=fp.bssid_map;
%         subfp.cdns_m=[];
%         subfp.rssis_m=[];
%         subfp.magnetics_m=[];
%         subfp.cdns=fp.cdns(area_mask,:);
%         subfp.rssis=fp.rssis(area_mask,:);
%         subfp.magnetics=fp.magnetics(area_mask,:);
%         subfp.wfiles=fp.wfiles(area_mask);
%         subfp.sfiles=fp.sfiles(area_mask);
%         subfp.duties=fp.duties(area_mask,:);
%         for p=1:size(subfp.cdns,1)
%             tmp_cdn=subfp.cdns(p,:);
%             [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(subfp.wfiles{p},subfp.bssid_map);
%             tmp_magnetics=process_magnetic(subfp.sfiles{p},RecordsNum,mag_cols,test_time);
%             if is_average
%                 export_data_append_average;
%             else
%                 export_data_append;
%             end
%         end
%         subfp.cdns_m=[subfp.cdns_m ; repmat( tmp_cdn , RecordsNum , 1 )];
%         subfp.magnetics_m=[subfp.magnetics_m ; tmp_magnetics];
%         subfp.rssis_m=[subfp.rssis_m ; tmp_rssi];
%         [mag_max,mag_min]=get_magnetic_statics(area_i,magnetic_dim);
%         [cdn_max,cdn_min]=get_cdns_statics(area_i);
%         cdns_m=cdns_m-cdn_min;
%         %         if magnetic_dim==1
%         %             magnetics_m=mnorm(magnetics_m,2);
%         %         end
%         magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
%         rssis_m=(rssis_m+100)/70;
%         rssis_m(rssis_m<0)=0;
%         rssis_m(rssis_m>1)=1;
%         m=[repmat(area_code,size(cdns_m,1),1) cdns_m magnetics_m rssis_m];
%         disp([save_path area_table{area_i} '_soft' n2s(area_code) '_training.csv']);
%         csvwrite([save_path area_table{area_i} '_soft' n2s(area_code) '_training.csv'],m);
%     end
% end

% %%
% is_average=true;
% 
% %% area predict test
% for i=1:length(areas)
%     area_i=areas(i);
%     fp=fps{area_i};
%     td=tds{area_i};
%     td.categorical_vector=get_subarea_soft(fp.area_vertexs,td.cdns);
%     categorical_vector_m=[];
%     cdns_m=[];
%     rssis_m=[];
%     magnetics_m=[];
%     td_no=1:td.num;
%     td_no(remove_no)=[];
%     for t=td_no
%         tmp_cdn=td.cdns(t,:);
%         [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(td.wfiles{t},fp.bssid_map);
%         tmp_magnetics=process_magnetic(td.sfiles{t},RecordsNum,mag_cols,test_time);
%         if is_average
%             RecordsNum=10;
%             categorical_vector_m=[categorical_vector_m ;  repmat(td.categorical_vector(t,:),RecordsNum,1)];
%             cdns_m=[cdns_m; repmat(tmp_cdn,RecordsNum,1)];
%             rssis_m=[rssis_m; repmat(mean(tmp_rssi),RecordsNum,1)];
%             magnetics_m=[magnetics_m; repmat(mean(tmp_magnetics),RecordsNum,1)];
%             %             export_data_append_average;
%         else
%             categorical_vector_m=[categorical_vector_m ; repmat(td.categorical_vector(t,:),RecordsNum,1)];
%             export_data_append;
%         end
%     end
%     [mag_max,mag_min]=get_magnetic_statics(area_i,magnetic_dim);
%     [cdn_max,cdn_min]=get_cdns_statics(area_i);
%     cdns_m=cdns_m-cdn_min;
%     %     if magnetic_dim==1
%     %         magnetics_m=mnorm(magnetics_m,2);
%     %     end
%     magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
%     rssis_m=(rssis_m+100)/70;
%     rssis_m(rssis_m<0)=0;
%     rssis_m(rssis_m>1)=1;
%     m=[categorical_vector_m cdns_m magnetics_m rssis_m];
%     disp([save_path area_table{area_i} '_soft0_testing.csv']);
%     csvwrite([save_path area_table{area_i} '_soft0_testing.csv'],m);
% end
% 
% %% cdn predict test
% for i=1:length(areas)
%     area_i=areas(i);
%     fp=fps{area_i};
%     td=tds{area_i};
%     td.categorical_vector=get_subarea_soft(fp.area_vertexs,td.cdns);
%     area_code_num=size(fp.categorical_vector,2);
%     for area_code=1:area_code_num
%         area_mask=td.categorical_vector(:,area_code)>0;
%         cdns_m=[];
%         rssis_m=[];
%         magnetics_m=[];
%         
%         subtd.i_area=td.i_area;
%         subtd.sub_i=area_code;
%         subtd.bssid_map=td.bssid_map;
%         subtd.cdns=td.cdns(area_mask,:);
%         subtd.rssis=td.rssis(area_mask,:);
%         subtd.magnetics=td.magnetics(area_mask,:);
%         subtd.wfiles=td.wfiles(area_mask);
%         subtd.sfiles=td.sfiles(area_mask);
%         for p=1:size(subtd.cdns,1)
%             tmp_cdn=subtd.cdns(p,:);
%             [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(subtd.wfiles{p},subtd.bssid_map);
%             tmp_magnetics=process_magnetic(subtd.sfiles{p},RecordsNum,mag_cols,test_time);
%             if is_average
%                 RecordsNum=10;
%                 cdns_m=[cdns_m; repmat(tmp_cdn,RecordsNum,1)];
%                 rssis_m=[rssis_m; repmat(mean(tmp_rssi),RecordsNum,1)];
%                 magnetics_m=[magnetics_m; repmat(mean(tmp_magnetics),RecordsNum,1)];
%                 %                 export_data_append_average;
%             else
%                 export_data_append;
%             end
%         end
%         subtd.cdns_m=cdns_m;
%         subtd.magnetics_m=magnetics_m;
%         subtd.rssis_m=rssis_m;
%         [mag_max,mag_min]=get_magnetic_statics(area_i,magnetic_dim);
%         [cdn_max,cdn_min]=get_cdns_statics(area_i);
%         cdns_m=cdns_m-cdn_min;
%         %         if magnetic_dim==1
%         %             magnetics_m=mnorm(magnetics_m,2);
%         %         end
%         magnetics_m=my_norm(magnetics_m,mag_max,mag_min);
%         rssis_m=(rssis_m+100)/70;
%         rssis_m(rssis_m<0)=0;
%         rssis_m(rssis_m>1)=1;
%         m=[repmat(area_code,size(cdns_m,1),1) cdns_m magnetics_m rssis_m];
%         disp([save_path area_table{area_i} '_soft' n2s(area_code) '_testing.csv']);
%         csvwrite([save_path area_table{area_i} '_soft' n2s(area_code) '_testing.csv'],m);
%     end
% end
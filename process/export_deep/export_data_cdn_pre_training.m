%%
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

% 参数设置
areas=[1 2 4 5 10 11 14];%[1 2 4 5 10 11 14 15];
mag_cols=18:20;
test_time=1;
data_ver='0';
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

% remove_no=[75 145 215 216];
% remove_no=[1,27,50,165,299,357,102,369];
remove_no=[];

% %% area predict train
% for i=1:length(areas)
%     area_i=areas(i);
%     data_description.magnetic_dim=magnetic_dim;
%     data_description.rssi_dim=fps{area_i}.rssi_mask_num;
%     save_json([save_path area_table{area_i}  '_data_description.json'],data_description);
% end
% %% pre_training data
% data_type='pre_training';
% for i=1:length(areas)
%     area_i=areas(i);
%     fp=fps{area_i};
%     rssis_input=[];
%     rssis_label=[];
%     rssi_mask=get_rssi_mask(fp);
%     for r=1:fp.num
%         [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(fp.wfiles{r},fp.bssid_map,'0',fps_rssi_freq(area_i),test_time,rssi_mask);
%         rssis_input=[rssis_input ; tmp_rssi];
%         tmp_label=fp.rssis{r};
%         rssis_label=[rssis_label ; repmat(tmp_label(:,rssi_mask),RecordsNum,1)];
%     end
%     rssis_input=my_norm(rssis_input,max_rssi,min_rssi);
%     rssis_label=my_norm(rssis_label,max_rssi,min_rssi);
%     m=[rssis_label rssis_input];
%     disp([save_path area_table{area_i}  '_' data_type '.csv']);
%     csvwrite([save_path area_table{area_i}  '_' data_type '.csv'],m);
% end
% 
% %% pre_testing data
% data_type='pre_testing';
% for i=1:length(areas)
%     area_i=areas(i);
%     fp=fps{area_i};
%     td=tds{area_i};
%     rssis_input=[];
%     rssis_label=[];
%     td_no=1:td.num;
%     td_no(remove_no)=[];
%     rssi_mask=get_rssi_mask(fp);
%     for r=1:fp.num
%         [tmp_rssi,bssid_maps,bssid_indexs,RecordsNum]=process_wifi(fp.wfiles{r},fp.bssid_map,'1',fps_rssi_freq(area_i),test_time,rssi_mask);
%         rssis_input=[rssis_input ; tmp_rssi];
%         tmp_label=fp.rssis{r};
%         rssis_label=[rssis_label ; repmat(tmp_label(:,rssi_mask),RecordsNum,1)];
%     end
%     rssis_input=my_norm(rssis_input,max_rssi,min_rssi);
%     rssis_label=my_norm(rssis_label,max_rssi,min_rssi);
%     m=[rssis_label rssis_input];
%     disp([save_path area_table{area_i}  '_' data_type '.csv']);
%     csvwrite([save_path area_table{area_i}  '_' data_type '.csv'],m);
% end
%% mixed pre_training data
data_type='pre_training_m';
for i=1:length(areas)
    area_i=areas(i);
    disp([save_path area_table{area_i}  '_pre_training.csv']);
    pre_training=csvread([save_path area_table{area_i}  '_pre_training.csv']);
    disp([save_path area_table{area_i}  '_pre_testing.csv']);
    pre_testing=csvread([save_path area_table{area_i}  '_pre_testing.csv']);
    pre_testing=repmat(pre_testing,floor(size(pre_training,1)/size(pre_testing,1)),1);
    m=[pre_training;pre_testing];
    disp([save_path area_table{area_i}  '_' data_type '.csv']);
    csvwrite([save_path area_table{area_i}  '_' data_type '.csv'],m);
end

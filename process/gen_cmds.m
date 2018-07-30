clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load(['data/fingerprints' data_version '.mat']);

areas=[1 2 4 5 9 10 11 14 15];%[1 10];
batch_sizes=64;%[64 32 16];
dropouts=[0.2];
exp_num='dnn';
feature_modes={'M','MM','R','RM','RMM'};

paras.pro_name='cdn_predict.py';
paras.data_ver='0';
paras.epoch=50;

for i=1:length(areas)
    area_i=areas(i);
    paras.data_name=area_table{area_i};
    paras.batch_size=2^floor(log2(fps{area_i}.num*fps_rssi_freq(area_i)*fps_rssi_time(area_i)/1024));
    if paras.batch_size<4
        paras.batch_size=4;
    end
    for d=dropouts
        paras.dropout=d;
%             exp_num=['DNN_' n2s(b) '_' n2s(d)];
        paras.exp_num=exp_num;
        for f=1:length(feature_modes)
            paras.feature_mode=feature_modes{f};
            disp(gen_cmd(paras));
        end
    end
end
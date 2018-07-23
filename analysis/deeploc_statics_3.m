clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

pro_name='cdn_predict';
data_ver='0';
area_code='0';
areas=[1 10];
data_label='deeploc';
epochs=1;
batch_sizes=64;%[64 32 16];
dropouts=0;%[0 0.2 0.5];
code_dims=[2 4 8 16];
pre_trainings={'AE-0','VAE-0'};%{'AE-0_encoder','AE-1_encoder','VAE-0_encoder','AE-1_encoder'};
dnn_models={'DNN-0','DNN-1','DNN-2'};
data1=zeros(length(areas),length(batch_sizes),length(dropouts),length(code_dims),length(pre_trainings));
data2=zeros(length(areas),length(batch_sizes),length(dropouts),1);
data3=zeros(length(areas),length(batch_sizes),length(dropouts),length(dnn_models));

for i=1:length(areas)
    area_i=areas(i);
    data_name=[area_table{area_i} '_' data_label];
    for b=1:length(batch_sizes)
        for d=1:length(dropouts)
            x=['DNN_bs_' n2s(batch_sizes(b)) '_d_' n2s(dropouts(d))];
            for m=1:length(dnn_models)
                filename=[deeploc_path '\result\' x '\' data_name area_code '_' pro_name '_' dnn_models{m} '_evaluate.csv'];
                if ~exist(filename,'file')
                    disp(['file not found: ' filename]);
                else
                    a=csvread(filename,1,1);
                    data3(i,b,d,m)=a(2);
                end
            end
            for c=1:length(code_dims)
                x=['AE_bs_' n2s(batch_sizes(b)) '_d_' n2s(dropouts(d)) '_cd_' n2s(code_dims(c))];
                for pre=1:length(pre_trainings)
                    filename=[deeploc_path '\result\' x '\' data_name area_code '_' pro_name '_' pre_trainings{pre} '_encoder_DNN-0_evaluate.csv'];
                    if ~exist(filename,'file')
                        disp(['file not found: ' filename]);
                    else
                        a=csvread(filename,1,1);
                        data3(i,b,d,c,pre)=a(2);
                    end
                end
            end
            x=['AP_bs_' n2s(batch_sizes(b)) '_d_' n2s(dropouts(d))];
            filename=[deeploc_path '\result\' x '\' data_name area_code '_' pro_name '_AP_DNN-0_evaluate.csv'];
            if ~exist(filename,'file')
                disp(['file not found: ' filename]);
            else
                a=csvread(filename,1,1);
                data3(i,b,d,1)=a(2);
            end
        end
    end
end
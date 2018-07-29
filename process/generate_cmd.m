clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

pro_name='cdn_predict';
data_ver='3';
areas=[1 10];%[1 10];
data_label='deeploc';
epochs=80;
batch_sizes=64;%[64 32 16];
dropouts=[0 0.1 0.2];
code_dims=8; %[2 4 8 16];
pre_trainings={'AE-0'};%{'AE-0_encoder','AE-1_encoder','VAE-0_encoder','AE-1_encoder'};
dnn_models={'DNN-0'};% ,'DNN-1','DNN-2'
%% pre_training
% for i=1:length(areas)
%     area_i=areas(i);
%     data_name=[area_table{area_i} '_soft'];
%     x='pre_model/AP';
%     disp(['python3 area_pre.py -v ' data_ver ' -n ' data_name ' -x ' x]);
% end
% for i=1:length(areas)
%     area_i=areas(i);
%     data_name=[area_table{area_i} '_' data_label];
%     for d=dropouts
%         for c=code_dims
%             x=['pre_model/AE_' n2s(c) '_' n2s(d)];
%             for pre=pre_trainings
%                 disp(['python3 rssi_pre.py -v ' data_ver ' -n ' data_name  ' -d ' n2s(d) ' -x ' x ' -p ' cell2mat(pre) ' -z ' n2s(c)]);
%             end
%         end
%     end
% end
% 
%% cdn_predict
% for i=1:length(areas)
%     area_i=areas(i);
%     data_name=[area_table{area_i} '_' data_label];
%     for b=batch_sizes
%         for d=dropouts
%             x=['DNN_' n2s(b) '_' n2s(d)];
%             for m=dnn_models
%                 disp(['python3 ' pro_name '.py -v ' data_ver ' -n ' data_name ' -d ' n2s(d) ' -b ' n2s(b)  ' -x ' x ' --dnn_model ' cell2mat(m)  ' -e ' n2s(epochs)]);
%             end
%             for pre=pre_trainings
%                 for c=code_dims
%                     x=['AE_' n2s(b) '_' n2s(d) '_' n2s(c)];
%                     disp(['python3 ' pro_name '.py -v ' data_ver ' -n ' data_name ' -d ' n2s(d) ' -b ' n2s(b) ' -x ' x ' -p ' cell2mat(pre) ' -z ' n2s(c) ' -e ' n2s(epochs)]);
%                 end
%             end
% %             x=['AP_' n2s(b) '_' n2s(d)];
% %             disp(['python3 ' pro_name '.py -v ' data_ver ' -n ' data_name ' -d ' n2s(d) ' -b ' n2s(b) ' -x ' x ' -p AP'  ' -e ' n2s(epochs)]);
%         end
%     end
% end

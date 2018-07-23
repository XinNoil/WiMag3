clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
areas=[1 10];
data_ver=0;
epochs=300;
batch_size=64;
x='new_model';
pro='deeploc';
data_label='cluster';
feature_mode='all';
for i=1:length(areas)
    % training
    area_i=areas(i);
    load(['data/fingerprints' data_version '.mat']);
    knum=fps{area_i}.knum;
    for s=1:knum
        disp(['python3 ' pro '.py -m -v ' n2s(data_ver) ' -n ' area_table{area_i} data_label ' -c ' n2s(s) ' -e ' n2s(epochs) ' -x ' x  ' -f ' feature_mode]);
    end
%     disp(['python3 ' pro '.py -v ' n2s(dv) ' -c ' n2s(s) ' -x ' x ' -n ' area_table{area_i} '_soft']);
end

% clear
% clc
% load glo.mat
% cd (work_path)
% disp(['data_version:' data_version]);
% areas=[1 2 4 5];
% dv=5;
% x='cdn_predict';
% pro='cdn_predict';
% % disp(['python3 ' pro '.py -x ' x]);
% for i=1:length(areas)
%     % training
%     area_i=areas(i);
%     load(['data/fingerprints' data_version '.mat']);
%     area_num=size(fps{area_i}.categorical_vector,2);
%     for s=1:area_num
%         disp(['python3 ' pro '.py -v ' n2s(dv) ' -c ' n2s(s) ' -x ' x ' -n ' area_table{area_i} '_soft']);
%     end
% %     disp(['python3 ' pro '.py -v ' n2s(dv) ' -c ' n2s(s) ' -x ' x ' -n ' area_table{area_i} '_soft']);
% end
% disp([' ']);
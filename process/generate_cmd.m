clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
areas=[1 2 4 5];
dv=5;
x='cdn_predict';
pro='cdn_predict';
% disp(['python3 ' pro '.py -x ' x]);
for i=1:length(areas)
    % training
    area_i=areas(i);
    load(['data/fingerprints' data_version '.mat']);
    area_num=size(fps{area_i}.categorical_vector,2);
    for s=1:area_num
        disp(['python3 ' pro '.py -v ' n2s(dv) ' -c ' n2s(s) ' -x ' x ' -n ' area_table{area_i} '_soft']);
    end
%     disp(['python3 ' pro '.py -v ' n2s(dv) ' -c ' n2s(s) ' -x ' x ' -n ' area_table{area_i} '_soft']);
end
disp([' ']);
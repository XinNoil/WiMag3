clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
areas_i=1;%[1 2 4 5];
x='3';
disp(['mkdir ' x]);
pro='WiMag_dnn_v2';
% disp(['python3 ' pro '.py -x ' x]);
for i=1:length(areas_i)
    % training
    area_i=areas_i(i);
    load(['data/fingerprints' data_version '.mat']);
    area_num=21;
    for s=1:area_num
        disp(['python3 ' pro '.py -c ' n2s(s) ' -x ' x ' -f data-soft -n ' area_table{area_i} '_soft']);
    end
end
disp([' ']);
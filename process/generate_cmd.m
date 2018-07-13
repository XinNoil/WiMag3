clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
areas_i=1;%[1 2 4 5];
x='3';
pro='cdn_predict';
% disp(['python3 ' pro '.py -x ' x]);
for i=1:length(areas_i)
    % training
    area_i=areas_i(i);
    load(['data/fingerprints' data_version '.mat']);
    area_num=21;
    for s=1:area_num
        disp(['python3 ' pro '.py -v 2 -c ' n2s(s) ' -x ' x ' -n ' area_table{area_i} '_soft']);
    end
end
disp([' ']);
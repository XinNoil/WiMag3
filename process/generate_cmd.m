clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
areas_i=1;%[1 2 4 5];
x='t';
disp(['mkdir ' x]);
pro='WiMag_dnn';
% disp(['python3 ' pro '.py -x ' x]);
for i=1:length(areas_i)
    % training
    area_i=areas_i(i);
    load(['data/fingerprints' data_version 's_' area_table{area_i} '.mat']);
    for s=1:length(sub_fps)
        fp=sub_fps{s};
        disp(['python3 ' pro '.py -c ' n2s(fp.sub_i) ' -x ' x]);
    end
    disp([' ']);
    for s=1:length(sub_fps)
        fp=sub_fps{s};
        disp([area_table{area_i} '-' n2s(fp.sub_i)]);
    end
end
disp([' ']);
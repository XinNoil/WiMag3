clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load (['data/fingerprints' data_version '.mat']);
is_rssi=[true true false true true];
i_areas=1:5;
i_areas=i_areas(is_rssi);
outdoor_magnetics=[28.5 -43.6];
for i=i_areas
    fp=fps{i};
%     disp(['����' n2s(i)]);
    fprintf('%s\t%s\n',n2s(fp.num),n2s(fp.num_i));
end
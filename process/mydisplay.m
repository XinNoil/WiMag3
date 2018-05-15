clear
clc
load glo.mat
cd (work_path)
data_version='1';
load (['data/fingerprints' data_version '.mat']);
is_rssi=[true true false true true];
i_areas=1:5;
i_areas=i_areas(is_rssi);
outdoor_magnetics=[28.5 -43.6];
for i=i_areas
    fp=fps{i};
%     disp(['ÇøÓò' n2s(i)]);
    fprintf('%s\t%s\n',n2s(fp.rqs_num),n2s(fp.rqs_num_i));
end
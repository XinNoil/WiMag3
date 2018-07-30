%% 输出参考点 测试点个数
clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);

areas=1:length(area_table);
% 载入数据
load (['data/fingerprints' data_version '.mat']);
load (['data/testdatas' data_version '.mat']);
% fprintf('fp\t\ttd\t\tap\t\tarea\n');
% for area_i=areas
%     fp=fps{area_i};
%     td=tds{area_i}; 
%     if ~isempty(td)&&isfield(fp,'bssid_map')
%         fprintf('%s\t\t%s\t\t%s\t\t%s\n',n2s(fp.num),n2s(td.num),n2s(length(fp.bssid_map)),area_table{area_i});
%     end
% end

fprintf('ap\tarea\n');
for area_i=areas
    fp=fps{area_i};
    td=tds{area_i}; 
    if isfield(fp,'bssid_map')
        fprintf('%s\t%s\n',n2s(length(fp.bssid_map)),area_table{area_i});
    end
end
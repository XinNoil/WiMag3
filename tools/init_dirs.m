function init_dirs( new_areas )
%INIT_DIRS 此处显示有关此函数的摘要
%   此处显示详细说明
load glo.mat;
if nargin>0
    area_table=union(area_table,new_areas);
end
for i=1:length(area_table)
    dir=['data/' area_table{i}];
    if ~exist(dir,'dir')
        mkdir(dir);
    end
    dir=['figures/' area_table{i}];
    if ~exist(dir,'dir')
        mkdir(dir);
    end
    dir=['original_data/' area_table{i}];
    if ~exist(dir,'dir')
        mkdir(dir);
    end
    dir=['result/' area_table{i}];
    if ~exist(dir,'dir')
        mkdir(dir);
    end
end
end


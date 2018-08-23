function settings=config_area( i_area )
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for getting the settings of i_area.
%           该函数用于获得i_area的settings。
% Contact:  jiankunwang@tju.edu.cn
load glo.mat area_table;
settings={};
area_name=area_table{i_area};
script_name=['set_' replace(area_name,'-','_')];
% excute the script in 'setting files'
eval(script_name);


function save_fingerprint(i_area,settings,s)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for saving a fingerprint.
%           该函数用于保存一个新的指纹库。
% Contact:  jiankunwang@tju.edu.cn
load glo.mat;
vars.plot_gridmesh='1';
newfig;
for i=1:length(settings)
    plot_floor(settings{i},false,vars);
end
if s.is_new_fingerprint
    fp=set_fingerprint(i_area,settings);
else
    load(['data/' area_table{i_area} '/fingerprint' s.data_version '.mat']);
    fp.settings=settings;
end
if s.is_save_fingerprint
    save(['data/' area_table{i_area} '/fingerprint' s.data_version '.mat'],'fp');
end
if s.is_savegcf
    if ~exist('setting files/setting figures/','dir')
        mkdir('setting files/setting figures/');
    end
    savegcf(['setting files/setting figures/' area_table{i_area}],{'png','fig'});
end
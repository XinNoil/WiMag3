function save_fingerprint(i_area,settings,s)
load glo.mat;
vars.plot01='1';
newfig;
for i=1:length(settings)
    if ~s.is_plot_magnetic_object
        if isfield(settings{i},'magnetic_object_cdns')
            settings{i}=rmfield(settings{i},'magnetic_object_cdns');
        end
        if isfield(settings{i},'magnetic_object_types')
            settings{i}=rmfield(settings{i},'magnetic_object_types');
        end
        if isfield(settings{i},'magnetic_room')
            settings{i}=rmfield(settings{i},'magnetic_room');
        end
    end
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
    savegcf(['setting files/' area_table{i_area}]);
end
end
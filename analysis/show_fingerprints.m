clear
clc
load glo.mat
cd (work_path)

data_version='1';
load(['data/fingerprints' data_version '.mat']);

areas=7;
for area_i=areas
    fp=fps{area_i};
    h=plot_floor_mark(fp.settings,fp.cdns,fp.magnitudes);
    set(h,'marker','s','markersize',10);
    fpcdns=fp.cdns;
    save data/tmp.mat fp fpcdns
    setupdatefun(@myupdatefcn3);
end

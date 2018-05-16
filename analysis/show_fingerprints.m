clear
clc
load glo.mat
cd (work_path)

data_version='1';
load(['data/fingerprints' data_version '.mat']);
show_type='rssi';

areas=1:length(area_table);
for area_i=7 % areas
    fp=fps{area_i};
    h=plot_floor_mark(fp.settings,fp.cdns,fp.magnitudes);
    set(h,'marker','s','markersize',10);
    fpcdns=fp.cdns;
    save data/tmp.mat fp fpcdns show_type 
    setupdatefun(@myupdatefcn3);
end
figure;
for i=1:3
    
    subplot(1,3,i);
    ap_map(fp,i);
end

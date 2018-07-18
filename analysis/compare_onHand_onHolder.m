clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load(['data/fingerprints' data_version '.mat']);

onHolder_area=8;
onHand_area=9;

areas=1:length(area_table);
for area_i=9 % areas
    fp_holder=fps{area_i};
    fp_hand=fps{area_i};
    h=plot_floor_mark(fp_holder.settings,fp.cdns,fp.magnitudes);
    set(h,'marker','s','markersize',10);
    fpcdns=fp_holder.cdns;
    save tmp/tmp.mat fp_holder fp_hand fpcdns show_type
    setupdatefun(@myupdatefcn_compare);
end
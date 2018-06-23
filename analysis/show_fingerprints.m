clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load(['data/fingerprints' data_version '.mat']);
show_type='rssi';

areas=1:length(area_table);
for area_i=5 % areas
    fp=fps{area_i};
    h=plot_floor_mark(fp.settings,fp.cdns,fp.magnitudes);
    set(h,'marker','s','markersize',10);
    fpcdns=fp.cdns;
    save data/tmp.mat fp fpcdns show_type 
    setupdatefun(@myupdatefcn3);
end

% distances=pair_euclidean_distance(cell2mat(fp.rssis));
% mycdfplot(distances(:),1,'Euclidean distance','CDF','b','-');

% rssis=cell2mat(fp.rssis);
% bssids={'68:db:54:b9:99:ce','70:ba:ef:c6:bc:40','b0:95:8e:16:5d:35'};
% figure;
% for i=1:3
%     subplot(1,3,i);
%     index=fp.bssid_map(bssids{i});
%     mycdfplot(rssis(:,index),0,'RSSI','CDF')
% end
% figure;
% for i=1:3
%     subplot(1,3,i);
%     index=fp.bssid_map(bssids{i});
%     ap_map(fp,index);
% end

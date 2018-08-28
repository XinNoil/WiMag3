clear
clc
load glo.mat
cd (work_path)
disp(['data_version:' data_version]);
load(['data/fingerprints' data_version '.mat']);
load(['data/testdatas' data_version '.mat']);
show_fptd = containers.Map({'fp','td'}, {true,false});
show_type='mag';

areas=4;%1:length(area_table);
for area_i=areas
    fp=fps{area_i};
    td=tds{area_i};
    if show_fptd('fp')
        if show_fptd('td')
            cdns=[fp.cdns;td.cdns];
            magnitudes=[fp.magnitudes;td.magnitudes];
        else
            cdns=fp.cdns;
            magnitudes=fp.magnitudes;
        end
    elseif show_fptd('td')
        cdns=td.cdns;
        magnitudes=td.magnitudes;
    end
    h=plot_floor_mark(fp.settings,cdns,magnitudes);
    set(h,'marker','s','markersize',10);
    fpcdns=fp.cdns;
    if isempty(td)
        show_fptd('td')=false;
        save tmp/tmp.mat fp fpcdns show_type show_fptd
    else
        tdcdns=td.cdns;
        save tmp/tmp.mat td fp fpcdns tdcdns show_type show_fptd
    end
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

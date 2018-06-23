function show_rssi_map(fp,td,rssi_index)
fprssis=cell2mat(fp.rssis);
h=plot_floor_mark(fp.settings,fp.cdns,fprssis(:,rssi_index));
set(h,'marker','s','markersize',10);
tdrssis=cell2mat(td.rssis);
h=plot_floor_mark(fp.settings,td.cdns,tdrssis(:,rssi_index),0);
set(h,'marker','s','markersize',10);
setupdatefun(@myupdatefcn3);
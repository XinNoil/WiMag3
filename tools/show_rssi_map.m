function show_rssi_map(fp,td,rssi_index)
fprssis=cell2mat(fp.rssis);
tdrssis=cell2mat(td.rssis);
cdns=[fp.cdns;td.cdns];
rssis=[fprssis(:,rssi_index);tdrssis(:,rssi_index)];
h=plot_floor_mark(fp.settings,cdns,rssis);
set(h,'marker','s','markersize',10);
setupdatefun(@myupdatefcn3);
function show_rssi_map(fp,td,rssi_index,show_fptd)
fprssis=cell2mat(fp.rssis);
if show_fptd('fp')
    if show_fptd('td')
        tdrssis=cell2mat(td.rssis);
        cdns=[fp.cdns;td.cdns];
        rssis=[fprssis(:,rssi_index);tdrssis(:,rssi_index)];
    else
        cdns=fp.cdns;
        rssis=fprssis(:,rssi_index);
    end
elseif show_fptd('td')
    tdrssis=cell2mat(td.rssis);
    cdns=td.cdns;
    rssis=tdrssis(:,rssi_index);
end
h=plot_floor_mark(fp.settings,cdns,rssis);
set(h,'marker','s','markersize',10);
setupdatefun(@myupdatefcn3);
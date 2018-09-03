function show_loss_map(fp,td,rssi_index,show_fptd)
duties=[fp.rssi_statics.duties];
duties=reshape(duties,fp.ap_num,fp.num);
if show_fptd('fp')
    if show_fptd('td')
%         tdrssis=cell2mat(td.rssis);
%         cdns=[fp.cdns;td.cdns];
%         rssis=[fprssis(:,rssi_index);tdrssis(:,rssi_index)];
    else
        cdns=fp.cdns;
        fploss=1-duties(rssi_index,:);
    end
% elseif show_fptd('td')
%     tdrssis=cell2mat(td.rssis);
%     cdns=td.cdns;
%     rssis=tdrssis(:,rssi_index);
end
h=plot_floor_mark(fp.settings,cdns,fploss,1,[0,1]);
set(h(fploss<1),'marker','s','markersize',10);
delete(h(fploss==1));
setupdatefun(@myupdatefcn3);
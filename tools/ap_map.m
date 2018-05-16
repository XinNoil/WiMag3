function ap_map(fp,index)
rssis=cell2mat(fp.rssis);
h=plot_floor_mark(fp.settings,fp.cdns,rssis(:,index),1);
set(h,'marker','s','markersize',10);
bssids=keys(fp.bssid_map);
title([n2s(index) ' -- ' bssids{index}]);
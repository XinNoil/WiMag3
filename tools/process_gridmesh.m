function results=process_gridmesh(gridmesh,is_rssi,mag_cols,bssid_map,origin,head,tail)
type=gridmesh.type;
switch type
    case '0'
        disp('参考点...');
    case '1'
        disp('测试点...');
end
% 默认有地磁数据
[cdns,magnetics,types,sfiles]=process_gridmesh_m(gridmesh,mag_cols,origin,head,tail,type);
results.cdns=cdns;
results.magnetics=magnetics;
results.types=types;
results.sfiles=sfiles;
if (is_rssi) %如果有WiFi
    [~,rssis,bssid_maps,bssid_indexs,wfiles,rssis_statics]=process_gridmesh_w(gridmesh,bssid_map,origin,head,tail,type);
    results.rssis=rssis;
    results.bssid_maps=bssid_maps;
    results.bssid_indexs=bssid_indexs;
    results.wfiles=wfiles;
    results.rssis_statics=rssis_statics;
end


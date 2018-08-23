function results=process_gridmesh(gridmesh,is_rssi,mag_cols,bssid_map,origin,head,tail,check_file_mode)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for processing origin data of a gridmesh.
%           该函数用于处理一个gridmesh的原始数据。
% Contact:  jiankunwang@tju.edu.cn
type=gridmesh.type;
switch type
    case '0'
        disp('参考点...');
    case '1'
        disp('测试点...');
end
%% 处理地磁数据
[cdns,magnetics,types,sfiles]=process_gridmesh_m(gridmesh,mag_cols,origin,head,tail,type,check_file_mode);
results.cdns=cdns;
results.magnetics=magnetics;
results.types=types;
results.sfiles=sfiles;
%% 处理WiFi数据
if (is_rssi)
    [~,rssis,bssid_maps,bssid_indexs,wfiles,duties,rssi_statics]=process_gridmesh_w(gridmesh,bssid_map,origin,head,tail,type,check_file_mode);
    results.rssis=rssis;
    results.bssid_maps=bssid_maps;
    results.bssid_indexs=bssid_indexs;
    results.wfiles=wfiles;
    results.duties=duties;
    results.rssi_statics=rssi_statics;
end

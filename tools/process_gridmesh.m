function results=process_gridmesh(gridmesh,is_rssi,mag_cols,bssid_map,origin,head,tail,check_file_mode)
% Date:     2018/08/22
% Auther:   WJK
% Function: This function is used for processing origin data of a gridmesh.
%           �ú������ڴ���һ��gridmesh��ԭʼ���ݡ�
% Contact:  jiankunwang@tju.edu.cn
type=gridmesh.type;
switch type
    case '0'
        disp('�ο���...');
    case '1'
        disp('���Ե�...');
end
%% ����ش�����
[cdns,magnetics,types,sfiles]=process_gridmesh_m(gridmesh,mag_cols,origin,head,tail,type,check_file_mode);
results.cdns=cdns;
results.magnetics=magnetics;
results.types=types;
results.sfiles=sfiles;
%% ����WiFi����
if (is_rssi)
    [~,rssis,bssid_maps,bssid_indexs,wfiles,duties,rssi_statics]=process_gridmesh_w(gridmesh,bssid_map,origin,head,tail,type,check_file_mode);
    results.rssis=rssis;
    results.bssid_maps=bssid_maps;
    results.bssid_indexs=bssid_indexs;
    results.wfiles=wfiles;
    results.duties=duties;
    results.rssi_statics=rssi_statics;
end

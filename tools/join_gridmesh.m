function db = join_gridmesh( db,cdns,magnetics,rssis,bssid_maps,bssid_indexs,types )
%JOIN_GRIDMESH �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if nargin>4
    db.cdns=[db.cdns;cdns];
    db.magnetics=[db.magnetics;magnetics];
    db.rssis=[db.rssis;rssis];
    db.bssid_maps=[db.bssid_maps;bssid_maps];
    db.bssid_indexs=[db.bssid_indexs;bssid_indexs];
    db.types=[db.types;types];
else
    db.cdns=[db.cdns;cdns];
    db.magnetics=[db.magnetics;magnetics];
    db.types=[db.types;rssis];
end

